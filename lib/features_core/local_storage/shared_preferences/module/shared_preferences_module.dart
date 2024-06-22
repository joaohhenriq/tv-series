import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';

class SharedPreferencesModule extends Module {
  @override
  void binds(Injector i) async {
    i.add<SharedPreferencesClient>(() => SharedPreferencesClientImpl());
  }
}
