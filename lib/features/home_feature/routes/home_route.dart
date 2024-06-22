import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';

class HomeRoutes {
  static const String moduleRoute = '/home';
  static const String homeRoute = '/home_options';
}

class HomeNavigation {
  static const String homeOptions =
      HomeRoutes.moduleRoute + HomeRoutes.homeRoute;
  static const String tvSeries =
      HomeRoutes.moduleRoute + SeriesNavigation.tvSeries;
  static const String peopleSearch =
      HomeRoutes.moduleRoute + PeopleNavigation.searchPeople;
}