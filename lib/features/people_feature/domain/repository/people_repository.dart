import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class PeopleRepository {
  Future<Either<Failure, List<PersonEntity>>> getPersonByName(String name);
}