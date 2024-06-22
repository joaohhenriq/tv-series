import 'package:flutter/material.dart';

enum AuthStateEnum {
  initial,
  createPin,
  confirmPin,
}

class AuthState extends ChangeNotifier {
  AuthStateEnum authStateEnum = AuthStateEnum.initial;

  updateAuthState(AuthStateEnum authStateEnum) {
    this.authStateEnum = authStateEnum;
    notifyListeners();
  }
}