import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
  }
}
