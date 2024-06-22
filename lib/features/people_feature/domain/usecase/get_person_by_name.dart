import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class GetPersonByName {
  Future<Either<Failure, List<PersonEntity>>> call(String name);
}

class GetPersonByNameImpl implements GetPersonByName {
  GetPersonByNameImpl(this.repository);

  final PeopleRepository repository;

  @override
  Future<Either<Failure, List<PersonEntity>>> call(String name) async =>
      await repository.getPersonByName(name);
}
