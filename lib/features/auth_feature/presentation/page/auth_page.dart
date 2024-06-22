import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    required this.isPinSet,
    required this.setPin,
    required this.checkPin,
  });

  final IsPinSet isPinSet;
  final SetPin setPin;
  final CheckPin checkPin;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<AuthState>();
      await _fetchPin(
        updateAuthState: provider.updateAuthState,
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
                loadingButton: provider.pinLoadingButton,
                onTap: (String pin) => _setPin(
                  context: context,
                  pin: pin,
                  updatePinLoadingButton: provider.updatePinLoadingButton,
                ),
              );
            case AuthStateEnum.confirmPin:
              return PinHandlerWidget(
                description:
                    'Please, enter your pin with 4 numbers to access Tv Maze',
                buttonDescription: 'Check',
                loadingButton: provider.pinLoadingButton,
                onTap: (String pin) => _checkPin(
                  context: context,
                  pin: pin,
                  updatePinLoadingButton: provider.updatePinLoadingButton,
                ),
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
  }) async {
    updatePinLoadingButton(true);
    final result = await widget.setPin(pin);
    updatePinLoadingButton(false);
    if (result.isRight && result.right) {
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
  }) async {
    updatePinLoadingButton(true);
    final result = await widget.checkPin(pin);
    updatePinLoadingButton(false);
    if (result.isRight && result.right) {
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
}
