import 'package:local_auth/local_auth.dart';
import 'package:tv_series_app/features_core/auth/auth.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';

class BiometricClientImpl implements BiometricClient {
  BiometricClientImpl({
    required this.localAuthentication,
    required this.sharedPreferencesClient,
  });

  final LocalAuthentication localAuthentication;
  final SharedPreferencesClient sharedPreferencesClient;

  static const _biometricAuthKey = 'biometric_auth';

  @override
  Future<bool> isBiometricLoginForDeviceSupported() async =>
      await localAuthentication.isDeviceSupported();

  @override
  Future<void> getAvailableBiometrics() async =>
      await localAuthentication.getAvailableBiometrics();

  @override
  Future<bool> isBiometricAuthAllowed() async =>
      await sharedPreferencesClient.getBool(_biometricAuthKey) ?? false;

  @override
  Future<bool> allowBiometricAuth(bool value) async =>
      await sharedPreferencesClient.setBool(_biometricAuthKey, value);

  @override
  Future<bool> authenticate() async => await localAuthentication.authenticate(
        localizedReason: 'Authenticate',
        options: const AuthenticationOptions(stickyAuth: true),
      );
}
