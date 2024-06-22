import 'package:flutter/material.dart';

enum AuthStateEnum {
  initial,
  createPin,
  confirmPin,
}

class AuthState extends ChangeNotifier {
  AuthStateEnum authStateEnum = AuthStateEnum.initial;

  bool pinLoadingButton = false;
  bool isDeviceBiometricSupported = false;
  bool isDeviceBiometricAuthAllowed = false;

  void updateAuthState(AuthStateEnum authStateEnum) {
    this.authStateEnum = authStateEnum;
    notifyListeners();
  }

  void updatePinLoadingButton(bool loadingButton) {
    pinLoadingButton = loadingButton;
    notifyListeners();
  }

  void updateIsDeviceBiometricSupported(bool isDeviceBiometricSupported) {
    this.isDeviceBiometricSupported = isDeviceBiometricSupported;
    notifyListeners();
  }

  void updateIsDeviceBiometricAuthAllowed(bool isDeviceBiometricAuthAllowed) {
    this.isDeviceBiometricAuthAllowed = isDeviceBiometricAuthAllowed;
    notifyListeners();
  }
}