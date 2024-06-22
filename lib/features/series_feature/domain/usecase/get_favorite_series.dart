import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class GetFavoriteSeries {
  Future<Either<Failure, List<TvShowEntity>>> call();
}

class GetFavoriteSeriesImpl implements GetFavoriteSeries {
  GetFavoriteSeriesImpl({
    required this.repository,
    required this.favoriteSeriesSingleton,
  });

  final SeriesRepository repository;
  final FavoriteSeriesSingleton favoriteSeriesSingleton;

  @override
  Future<Either<Failure, List<TvShowEntity>>> call() async {
    final result = await repository.getFavoriteSeries();
    if (result.isRight) {
      favoriteSeriesSingleton.favoriteSeries = result.right;
    }
    return result;
  }
}
