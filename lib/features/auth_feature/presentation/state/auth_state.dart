import 'package:flutter/material.dart';

enum AuthStateEnum {
  initial,
  createPin,
  confirmPin,
}

class AuthState extends ChangeNotifier {
  AuthStateEnum authStateEnum = AuthStateEnum.initial;

  bool createPinLoadingButton = false;

  updateAuthState(AuthStateEnum authStateEnum) {
    this.authStateEnum = authStateEnum;
    notifyListeners();
  }

  updateCreatePinLoadingButton(bool loadingButton) {
    createPinLoadingButton = loadingButton;
    notifyListeners();
  }
}