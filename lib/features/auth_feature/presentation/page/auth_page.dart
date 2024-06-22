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
              return CreatePin(
                loadingButton: provider.createPinLoadingButton,
                onTap: (String pin) => _setPin(
                  context: context,
                  pin: pin,
                  updateCreatePinLoadingButton:
                      provider.updateCreatePinLoadingButton,
                ),
              );
            case AuthStateEnum.confirmPin:
              return Container();
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
    required void Function(bool) updateCreatePinLoadingButton,
  }) async {
    updateCreatePinLoadingButton(true);
    final result = await widget.setPin(pin);
    updateCreatePinLoadingButton(false);
    if (result.isRight) {
      return true;
    }

    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ops, something went wrong!. Please, try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return false;
  }
}
