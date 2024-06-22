import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_core/local_storage/local_storage.dart';
import 'package:tv_series_app/features_core/network/network.dart';

class SeriesModule extends Module {
  @override
  List<Module> get imports => [
        HttpModule(),
        SharedPreferencesModule(),
      ];

  @override
  void binds(Injector i) {
    // data sources
    i.add<SeriesRemoteDatasource>(() => SeriesRemoteDatasourceImpl(i.get()));
    i.add<SeriesLocalDatasource>(() => SeriesLocalDatasourceImpl(i.get()));

    // repositories
    i.add<SeriesRepository>(() => SeriesRepositoryImpl(
          localDatasource: i.get(),
          remoteDatasource: i.get(),
        ));

    // use cases
    i.add<GetTvSeriesByName>(() => GetTvSeriesByNameImpl(i.get()));
    i.add<GetTvSeriesByPage>(() => GetTvSeriesByPageImpl(i.get()));
    i.add<GetSeriesListItems>(() => GetSeriesListItemsImpl(
          getTvSeriesByPage: i.get(),
        ));
    i.add<GetEpisodesBySeriesId>(() => GetEpisodesBySeriesIdImpl(i.get()));
    i.add<GroupEpisodesBySeason>(() => GroupEpisodesBySeasonImpl());
    i.add<AddFavoriteSeries>(() => AddFavoriteSeriesImpl(
          repository: i.get(),
          favoriteSeriesSingleton: i.get(),
        ));
    i.add<DeleteFromFavoriteSeries>(() => DeleteFromFavoriteSeriesImpl(
          repository: i.get(),
          favoriteSeriesSingleton: i.get(),
        ));
    i.add<GetFavoriteSeries>(() => GetFavoriteSeriesImpl(
          repository: i.get(),
          favoriteSeriesSingleton: i.get(),
        ));
    i.add<IsSeriesFavorite>(() => IsSeriesFavoriteImpl(
          favoriteSeriesSingleton: i.get(),
        ));

    // singletons
    i.addSingleton(FavoriteSeriesSingleton.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      SeriesRoutes.tvSeriesRoute,
      child: (_) => ChangeNotifierProvider(
        create: (context) => TvSeriesState(),
        child: TvSeriesPage(
          getSeriesListItems: Modular.get(),
          getFavoriteSeries: Modular.get(),
        ),
      ),
    );
    r.child(
      SeriesRoutes.searchSeriesRoute,
      child: (_) => ChangeNotifierProvider(
        create: (context) => SearchSeriesState(),
        child: SearchSeriesPage(
          getTvSeriesByName: Modular.get(),
        ),
      ),
    );
    r.child(
      SeriesRoutes.seriesDetailRoute,
      child: (_) => ChangeNotifierProvider(
        create: (context) => SeriesDetailState(),
        child: SeriesDetailPage(
          tvShowEntity: r.args.data,
          getEpisodesBySeriesId: Modular.get(),
          groupEpisodesBySeason: Modular.get(),
          isSeriesFavorite: Modular.get(),
          addFavoriteSeries: Modular.get(),
          deleteFromFavoriteSeries: Modular.get(),
        ),
      ),
    );
    r.child(
      SeriesRoutes.episodeDetailRoute,
      child: (_) => EpisodeDetail(
        episode: r.args.data,
      ),
    );
    r.child(
      SeriesRoutes.favoriteSeriesRoute,
      child: (_) => ChangeNotifierProvider(
        create: (context) => FavoriteSeriesState(),
        child: FavoriteSeriesPage(
          favoriteSeriesSingleton: Modular.get(),
        ),
      ),
    );
  }
}
