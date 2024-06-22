import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.datasource);

  final AuthDataSource datasource;

  @override
  Future<Either<Failure, bool>> isPinSet() async {
    try {
      final isPinSet = await datasource.isPinSet();
      return Right(isPinSet);
    } on Exception {
      return Left(IsPinSetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setPin(String pin) async {
    try {
      final isPinSet = await datasource.setPin(pin);
      return Right(isPinSet);
    } on Exception {
      return Left(SetPinFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkPin(String pin) async {
    try {
      final isPinSet = await datasource.checkPin(pin);
      return Right(isPinSet);
    } on Exception {
      return Left(CheckPinFailure());
    }
  }
}
