class SeriesRoutes {
  static const String moduleRoute = '/series_module';
  static const String tvSeriesRoute = '/tv_series';
  static const String searchSeriesRoute = '/search_series';
  static const String seriesDetailRoute = '/series_detail';
  static const String episodeDetailRoute = '/episode_detail';
  static const String favoriteSeriesRoute = '/favorite_series';
}

class SeriesNavigation {
  static const String tvSeries =
      SeriesRoutes.moduleRoute + SeriesRoutes.tvSeriesRoute;
  static const String searchSeries =
      SeriesRoutes.moduleRoute + SeriesRoutes.searchSeriesRoute;
  static const String seriesDetail =
      SeriesRoutes.moduleRoute + SeriesRoutes.seriesDetailRoute;
  static const String episodeDetail =
      SeriesRoutes.moduleRoute + SeriesRoutes.episodeDetailRoute;
  static const String favoriteSeries =
      SeriesRoutes.moduleRoute + SeriesRoutes.favoriteSeriesRoute;
}
