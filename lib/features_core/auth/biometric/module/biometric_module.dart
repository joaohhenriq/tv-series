import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tv_series_app/features_core/auth/auth.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';

class BiometricModule extends Module {
  @override
  List<Module> get imports => [SharedPreferencesModule()];

  @override
  void exportedBinds(Injector i) async {
    i.add<BiometricClient>(() => BiometricClientImpl(
          localAuthentication: LocalAuthentication(),
          sharedPreferencesClient: i.get(),
        ));
  }
}
