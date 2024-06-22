import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class AddFavoriteSeries {
  Future<Either<Failure, List<TvShowEntity>>> call(TvShowEntity tvShowEntity);
}

class AddFavoriteSeriesImpl implements AddFavoriteSeries {
  AddFavoriteSeriesImpl({
    required this.repository,
    required this.favoriteSeriesSingleton,
  });

  final SeriesRepository repository;
  final FavoriteSeriesSingleton favoriteSeriesSingleton;

  @override
  Future<Either<Failure, List<TvShowEntity>>> call(
    TvShowEntity tvShowEntity,
  ) async {
    final result = await repository.addFavoriteSeries(tvShowEntity);
    if (result.isRight) {
      favoriteSeriesSingleton.favoriteSeries = result.right;
    }
    return result;
  }
}
