import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/series_feature/series_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class GetTvSeriesByPage {
  Future<Either<Failure, List<TvShowEntity>>> call(int page);
}

class GetTvSeriesByPageImpl implements GetTvSeriesByPage {
  GetTvSeriesByPageImpl(this.repository);

  final SeriesRepository repository;

  @override
  Future<Either<Failure, List<TvShowEntity>>> call(int page) async =>
      await repository.getTvSeriesByPage(page);
}
