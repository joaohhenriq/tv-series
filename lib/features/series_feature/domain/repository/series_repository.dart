import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<TvShowEntity>>> getTvSeriesByPage(int page);
  Future<Either<Failure, List<TvShowEntity>>> getTvSeriesByName(String name);
  Future<Either<Failure, List<EpisodeEntity>>> getEpisodesBySeriesId(int name);
  Future<Either<Failure, List<TvShowEntity>>> getFavoriteSeries();
  Future<Either<Failure, List<TvShowEntity>>> addFavoriteSeries(TvShowEntity tvShowEntity);
  Future<Either<Failure, List<TvShowEntity>>> deleteFromFavoriteSeries(int id);
}