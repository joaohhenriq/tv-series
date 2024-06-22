import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class GetEpisodesBySeriesId {
  Future<Either<Failure, List<EpisodeEntity>>> call(int name);
}

class GetEpisodesBySeriesIdImpl implements GetEpisodesBySeriesId {
  GetEpisodesBySeriesIdImpl(this.repository);

  final SeriesRepository repository;

  @override
  Future<Either<Failure, List<EpisodeEntity>>> call(int id) async =>
      await repository.getEpisodesBySeriesId(id);
}
