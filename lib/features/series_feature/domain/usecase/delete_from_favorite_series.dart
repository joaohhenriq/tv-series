import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class DeleteFromFavoriteSeries {
  Future<Either<Failure, List<TvShowEntity>>> call(int id);
}

class DeleteFromFavoriteSeriesImpl implements DeleteFromFavoriteSeries {
  DeleteFromFavoriteSeriesImpl({
    required this.repository,
    required this.favoriteSeriesSingleton,
  });

  final SeriesRepository repository;
  final FavoriteSeriesSingleton favoriteSeriesSingleton;

  @override
  Future<Either<Failure, List<TvShowEntity>>> call(int id) async {
    final result = await repository.deleteFromFavoriteSeries(id);
    if (result.isRight) {
      favoriteSeriesSingleton.favoriteSeries = result.right;
    }
    return result;
  }
}
