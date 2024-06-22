class PeopleRoutes {
  static const String moduleRoute = '/people_module';
  static const String searchPeopleRoute = '/search_people';
  static const String personDetailRoute = '/person_detail';
}

class PeopleNavigation {
  static const String searchSeries =
      PeopleRoutes.moduleRoute + PeopleRoutes.searchPeopleRoute;
  static const String personDetail =
      PeopleRoutes.moduleRoute + PeopleRoutes.personDetailRoute;
}
