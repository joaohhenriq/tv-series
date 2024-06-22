abstract class PinClient {
  Future<bool> isPinSet();
  Future<void> setPin(String pin);
  Future<bool> checkPin(String pin);
}