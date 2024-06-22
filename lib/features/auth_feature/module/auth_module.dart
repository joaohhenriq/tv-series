import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features/home_feature/home_feature.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      AuthRoutes.authRoute,
      child: (_) => const AuthPage(),
    );
    r.module(HomeRoutes.moduleRoute, module: HomeModule());
  }
}
