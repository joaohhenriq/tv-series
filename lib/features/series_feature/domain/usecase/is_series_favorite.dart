import 'package:tv_series_app/features/series_feature/series_feature.dart';

abstract class IsSeriesFavorite {
  Future<bool> call(int seriesId);
}

class IsSeriesFavoriteImpl implements IsSeriesFavorite {
  IsSeriesFavoriteImpl({required this.favoriteSeriesSingleton});

  final FavoriteSeriesSingleton favoriteSeriesSingleton;

  @override
  Future<bool> call(int seriesId) async {
    return favoriteSeriesSingleton.favoriteSeries
        .any((element) => element.id == seriesId);
  }
}
