import 'package:tv_series_app/features_core/auth/auth.dart';

abstract class AuthBiometricDataSource {
  Future<bool> isBiometricLoginForDeviceSupported();

  Future<void> getAvailableBiometrics();

  Future<bool> isBiometricAuthAllowed();

  Future<bool> allowBiometricAuth(bool value);

  Future<bool> authenticateBiometric();
}

class AuthBiometricDataSourceImpl implements AuthBiometricDataSource {
  AuthBiometricDataSourceImpl(this.biometricClient);

  final BiometricClient biometricClient;

  @override
  Future<bool> isBiometricLoginForDeviceSupported() async =>
      await biometricClient.isBiometricLoginForDeviceSupported();

  @override
  Future<void> getAvailableBiometrics() async =>
      await biometricClient.getAvailableBiometrics();

  @override
  Future<bool> isBiometricAuthAllowed() async =>
      await biometricClient.isBiometricAuthAllowed();

  @override
  Future<bool> allowBiometricAuth(bool value) async =>
      await biometricClient.allowBiometricAuth(value);

  @override
  Future<bool> authenticateBiometric() async =>
      await biometricClient.authenticate();
}
