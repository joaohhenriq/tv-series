import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class GetTvSeriesByName {
  Future<Either<Failure, List<TvShowEntity>>> call(String name);
}

class GetTvSeriesByNameImpl implements GetTvSeriesByName {
  GetTvSeriesByNameImpl(this.repository);

  final SeriesRepository repository;

  @override
  Future<Either<Failure, List<TvShowEntity>>> call(String name) async =>
      await repository.getTvSeriesByName(name);
}
