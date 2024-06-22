import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features_core/auth/auth.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';

class PinModule extends Module {
  @override
  List<Module> get imports => [SharedPreferencesModule()];

  @override
  void binds(Injector i) async {
    i.add<PinClient>(() => PinClientImpl(i.get()));
  }
}
