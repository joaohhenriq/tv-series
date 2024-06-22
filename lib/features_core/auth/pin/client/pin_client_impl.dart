import 'package:tv_series_app/features_core/auth/auth.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';

class PinClientImpl implements PinClient {
  final SharedPreferencesClient sharedPreferencesClient;

  PinClientImpl(this.sharedPreferencesClient);

  static const pinKey = 'pin';

  @override
  Future<bool> isPinSet() async {
    final pin = await _getPin();
    return pin.isNotEmpty;
  }

  @override
  Future<bool> checkPin(String pin) async {
    final savedPin = await _getPin();
    return savedPin == pin;
  }

  @override
  Future<bool> setPin(String pin) async {
    return await sharedPreferencesClient.setString(pinKey, pin);
  }

  Future<String> _getPin() async {
    final savedPin = await sharedPreferencesClient.getString(pinKey);
    return savedPin ?? '';
  }
}
