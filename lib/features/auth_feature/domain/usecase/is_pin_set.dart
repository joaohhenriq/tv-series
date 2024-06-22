import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class IsPinSet {
  Future<Either<Failure, bool>> call();
}

class IsPinSetImpl implements IsPinSet {
  IsPinSetImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, bool>> call() async => authRepository.isPinSet();
}