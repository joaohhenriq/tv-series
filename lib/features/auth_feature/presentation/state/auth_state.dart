import 'package:flutter/material.dart';

enum AuthStateEnum {
  initial,
  createPin,
  confirmPin,
}

class AuthState extends ChangeNotifier {
  AuthStateEnum authStateEnum = AuthStateEnum.initial;

  bool pinLoadingButton = false;

  updateAuthState(AuthStateEnum authStateEnum) {
    this.authStateEnum = authStateEnum;
    notifyListeners();
  }

  updatePinLoadingButton(bool loadingButton) {
    pinLoadingButton = loadingButton;
    notifyListeners();
  }
}