import 'package:tv_series_app/features_core/auth/auth.dart';

abstract class AuthPinDataSource {
  Future<bool> isPinSet();
  Future<bool> setPin(String pin);
  Future<bool> checkPin(String pin);
}

class AuthPinDataSourceImpl implements AuthPinDataSource {
  AuthPinDataSourceImpl(this.pinClient);

  final PinClient pinClient;

  @override
  Future<bool> isPinSet() async => pinClient.isPinSet();

  @override
  Future<bool> setPin(String pin) async => pinClient.setPin(pin);

  @override
  Future<bool> checkPin(String pin) async => pinClient.checkPin(pin);
}
