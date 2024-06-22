import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

class SeriesRepositoryImpl with SortTvShowList implements SeriesRepository {
  SeriesRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final SeriesRemoteDatasource remoteDatasource;
  final SeriesLocalDatasource localDatasource;

  @override
  Future<Either<Failure, List<TvShowEntity>>> getTvSeriesByPage(
    int page,
  ) async {
    try {
      final result = await remoteDatasource.getTvSeriesByPage(page);
      if (result.isNotEmpty) {
        return Right(result);
      }
      return Left(GetTvSeriesByPageEmptyListFailure());
    } on GetTvSeriesByPageNotFoundException {
      return Left(GetTvSeriesByPageNotFoundFailure());
    } catch (e) {
      return Left(GetTvSeriesByPageCatchFailure());
    }
  }

  @override
  Future<Either<Failure, List<TvShowEntity>>> getTvSeriesByName(
    String name,
  ) async {
    try {
      final result = await remoteDatasource.getTvSeriesByName(name);
      if (result.isNotEmpty) {
        return Right(result);
      }
      return Left(GetTvSeriesByNameEmptyListFailure());
    } catch (e) {
      return Left(GetTvSeriesByNameCatchFailure());
    }
  }

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getEpisodesBySeriesId(
    int id,
  ) async {
    try {
      final result = await remoteDatasource.getEpisodesBySeriesId(id);
      if (result.isNotEmpty) {
        return Right(result);
      }
      return Left(GetEpisodesBySeriesIdEmptyListFailure());
    } catch (e) {
      return Future.value(Left(GetEpisodesBySeriesIdCatchFailure()));
    }
  }

  @override
  Future<Either<Failure, List<TvShowEntity>>> getFavoriteSeries() async {
    try {
      final result = await localDatasource.getFavoriteSeries();
      return result.isNotEmpty
          ? Right(sortTvShowList(result))
          : Left(GetFavoriteSeriesEmptyListFailure());
    } catch (e) {
      return Left(GetFavoriteSeriesCatchFailure());
    }
  }

  @override
  Future<Either<Failure, List<TvShowEntity>>> addFavoriteSeries(
    TvShowEntity tvShowEntity,
  ) async {
    try {
      final result = await localDatasource
          .addFavoriteSeries(TvShowModel.fromEntity(tvShowEntity));
      return Right(sortTvShowList(result));
    } on AddFavoriteSeriesException {
      return Left(AddFavoriteSeriesNotAddedFailure());
    } catch (e) {
      return Left(AddFavoriteSeriesCatchFailure());
    }
  }

  @override
  Future<Either<Failure, List<TvShowEntity>>> deleteFromFavoriteSeries(
    int id,
  ) async {
    try {
      final result = await localDatasource.deleteFromFavoriteSeries(id);
      return Right(sortTvShowList(result));
    } on DeleteFromFavoriteSeriesException {
      return Left(DeleteFromFavoriteSeriesNotRemovedFailure());
    } catch (e) {
      return Left(DeleteFromFavoriteSeriesCatchFailure());
    }
  }
}
