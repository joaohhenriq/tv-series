import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/people_feature/people_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  PeopleRepositoryImpl(this.datasource);

  final PeopleRemoteDatasource datasource;

  @override
  Future<Either<Failure, List<PersonEntity>>> getPersonByName(String name) async {
    try {
      final result = await datasource.getPersonByName(name);
      if (result.isNotEmpty) {
        return Right(result);
      }
      return Left(GetPeopleByNameEmptyListFailure());
    } catch (e) {
      return Left(GetPeopleByNameCatchFailure());
    }
  }
}
