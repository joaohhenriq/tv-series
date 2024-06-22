abstract class BiometricClient {
  Future<bool> isBiometricLoginForDeviceSupported();
  Future<void> getAvailableBiometrics();
  Future<bool> isBiometricAuthAllowed();
  Future<bool> allowBiometricAuth(bool value);
  Future<bool> authenticate();
}