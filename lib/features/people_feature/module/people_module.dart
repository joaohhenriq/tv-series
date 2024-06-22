import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features_core/network/network.dart';

class PeopleModule extends Module {
  @override
  List<Module> get imports => [HttpModule()];

  @override
  void binds(Injector i) {
    // data sources
    i.add<PeopleRemoteDatasource>(() => PeopleRemoteDatasourceImpl(i.get()));

    // repositories
    i.add<PeopleRepository>(() => PeopleRepositoryImpl(i.get()));

    // use cases
    i.add<GetPersonByName>(() => GetPersonByNameImpl(i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      PeopleRoutes.searchPeopleRoute,
      child: (_) => ChangeNotifierProvider(
        create: (context) => SearchPeopleState(),
        child: SearchPeoplePage(
          getPersonByName: Modular.get(),
        ),
      ),
    );
    r.child(
      PeopleRoutes.personDetailRoute,
      child: (_) => PersonDetail(
        personEntity: r.args.data,
      ),
    );
  }
}
