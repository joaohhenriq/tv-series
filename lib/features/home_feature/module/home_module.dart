import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features/home_feature/home_feature.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      HomeRoutes.homeRoute,
      child: (_) => const HomePage(),
    );
    r.module(SeriesRoutes.moduleRoute, module: SeriesModule());
    r.module(PeopleRoutes.moduleRoute, module: PeopleModule());
  }
}
