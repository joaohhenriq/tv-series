import 'package:either_dart/either.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> isPinSet();
  Future<Either<Failure, bool>> setPin(String pin);
  Future<Either<Failure, bool>> checkPin(String pin);
}