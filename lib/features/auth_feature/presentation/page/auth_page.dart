import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features/home_feature/home_feature.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    required this.isPinSet,
    required this.setPin,
    required this.checkPin,
    required this.allowBiometricAuth,
    required this.isBiometricAuthAllowed,
    required this.authenticateBiometric,
    required this.getAvailableBiometrics,
    required this.isBiometricLoginForDeviceSupported,
  });

  final IsPinSet isPinSet;
  final SetPin setPin;
  final CheckPin checkPin;
  final AllowBiometricAuth allowBiometricAuth;
  final IsBiometricAuthAllowed isBiometricAuthAllowed;
  final AuthenticateBiometric authenticateBiometric;
  final GetAvailableBiometrics getAvailableBiometrics;
  final IsBiometricLoginForDeviceSupported isBiometricLoginForDeviceSupported;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = ReadContext(context).read<AuthState>();
      await _fetchPin(updateAuthState: provider.updateAuthState);
      await _fetchBiometric(
        updateIsDeviceBiometricSupported:
            provider.updateIsDeviceBiometricSupported,
        updateIsDeviceBiometricAuthAllowed:
            provider.updateIsDeviceBiometricAuthAllowed,
      );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Authentication'),
        ),
        body: Consumer<AuthState>(builder: (context, provider, child) {
          switch (provider.authStateEnum) {
            case AuthStateEnum.initial:
              return const Center(child: CircularProgressIndicator());
            case AuthStateEnum.createPin:
              return PinHandlerWidget(
                description:
                    'Please, create a pin with 4 numbers to access Tv Maze',
                buttonDescription: 'Create',
                isDeviceBiometricAuthAllowed:
                    provider.isDeviceBiometricAuthAllowed,
                isDeviceBiometricSupported: provider.isDeviceBiometricSupported,
                loadingButton: provider.pinLoadingButton,
                onTapButton: (String pin, bool allowBioAuth) => _setPin(
                  context: context,
                  pin: pin,
                  updatePinLoadingButton: provider.updatePinLoadingButton,
                  allowBioAuth: allowBioAuth,
                ),
                onTapCheckBiometric:
                    provider.updateIsDeviceBiometricAuthAllowed,
              );
            case AuthStateEnum.confirmPin:
              return PinHandlerWidget(
                description:
                    'Please, enter your pin with 4 numbers to access Tv Maze',
                buttonDescription: 'Check',
                isDeviceBiometricAuthAllowed:
                    provider.isDeviceBiometricAuthAllowed,
                isDeviceBiometricSupported: provider.isDeviceBiometricSupported,
                loadingButton: provider.pinLoadingButton,
                onTapButton: (String pin, bool allowBioAuth) => _checkPin(
                  context: context,
                  pin: pin,
                  updatePinLoadingButton: provider.updatePinLoadingButton,
                  allowBioAuth: allowBioAuth,
                ),
                onTapCheckBiometric:
                    provider.updateIsDeviceBiometricAuthAllowed,
              );
          }
        }),
      );

  Future<void> _fetchPin({
    required void Function(AuthStateEnum) updateAuthState,
  }) async {
    final isPinSetValue = await widget.isPinSet();
    if (isPinSetValue.isRight && !isPinSetValue.right) {
      updateAuthState(AuthStateEnum.createPin);
    } else {
      updateAuthState(AuthStateEnum.confirmPin);
    }
  }

  Future<bool> _setPin({
    required BuildContext context,
    required String pin,
    required void Function(bool) updatePinLoadingButton,
    required bool allowBioAuth,
  }) async {
    updatePinLoadingButton(true);
    final result = await widget.setPin(pin);
    updatePinLoadingButton(false);
    if (result.isRight && result.right) {
      await widget.allowBiometricAuth(allowBioAuth);
      return true;
    }

    if (context.mounted) {
      _callSnackbarError(
        context: context,
        message: 'Ops, something went wrong!. Please, try again.',
      );
    }
    return false;
  }

  Future<bool> _checkPin({
    required BuildContext context,
    required String pin,
    required void Function(bool) updatePinLoadingButton,
    required bool allowBioAuth,
  }) async {
    updatePinLoadingButton(true);
    final result = await widget.checkPin(pin);
    updatePinLoadingButton(false);
    if (result.isRight && result.right) {
      await widget.allowBiometricAuth(allowBioAuth);
      return true;
    }

    if (context.mounted) {
      _callSnackbarError(
        context: context,
        message: 'Ops, the pin entered is incorrect. Please, try again.',
      );
    }
    return false;
  }

  void _callSnackbarError({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _fetchBiometric({
    required void Function(bool) updateIsDeviceBiometricSupported,
    required void Function(bool) updateIsDeviceBiometricAuthAllowed,
  }) async {
    bool isSupported = await _isDeviceBiometricSupported(
      updateIsDeviceBiometricSupported: updateIsDeviceBiometricSupported,
    );
    if (isSupported) {
      await widget.getAvailableBiometrics();
      bool isAllowed = await _isBiometricAuthAllowed(
        updateIsDeviceBiometricAuthAllowed: updateIsDeviceBiometricAuthAllowed,
      );
      if (isAllowed) {
        await _authenticateBiometric();
      }
    }
  }

  Future<bool> _isDeviceBiometricSupported({
    required void Function(bool) updateIsDeviceBiometricSupported,
  }) async {
    final isDeviceBiometricSupported =
        await widget.isBiometricLoginForDeviceSupported();
    if (isDeviceBiometricSupported.isRight) {
      updateIsDeviceBiometricSupported(isDeviceBiometricSupported.right);
      return isDeviceBiometricSupported.right;
    }
    return false;
  }

  Future<bool> _isBiometricAuthAllowed({
    required void Function(bool) updateIsDeviceBiometricAuthAllowed,
  }) async {
    final isBiometricAuthAllowed = await widget.isBiometricAuthAllowed();
    if (isBiometricAuthAllowed.isRight) {
      updateIsDeviceBiometricAuthAllowed(isBiometricAuthAllowed.right);
      return isBiometricAuthAllowed.right;
    }
    return false;
  }

  Future<void> _authenticateBiometric() async {
    if (!mounted) return;
    final isAuth = await widget.authenticateBiometric();
    if (isAuth.isRight && isAuth.right) {
      Modular.to.navigate(HomeNavigation.homeOptions);
    }
  }
}
