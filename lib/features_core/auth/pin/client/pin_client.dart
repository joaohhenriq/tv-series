abstract class PinClient {
  Future<bool> isPinSet();
  Future<bool> setPin(String pin);
  Future<bool> checkPin(String pin);
}