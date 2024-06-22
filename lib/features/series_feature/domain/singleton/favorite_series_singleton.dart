import 'package:tv_series_app/features/series_feature/series_feature.dart';

class FavoriteSeriesSingleton {
  List<TvShowEntity> _favoriteSeries = [];

  List<TvShowEntity> get favoriteSeries => _favoriteSeries;

  set favoriteSeries(List<TvShowEntity> value) => _favoriteSeries = value;
}