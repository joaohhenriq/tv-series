import 'package:tv_series_app/features/home_feature/routes/home_route.dart';

class PeopleRoutes {
  static const String moduleRoute = '/people_module';
  static const String searchPeopleRoute = '/search_people';
  static const String personDetailRoute = '/person_detail';
}

class PeopleNavigation {
  static const String searchPeople =
      PeopleRoutes.moduleRoute + PeopleRoutes.searchPeopleRoute;
  static const String personDetail =
      HomeRoutes.moduleRoute + PeopleRoutes.moduleRoute + PeopleRoutes.personDetailRoute;
}
