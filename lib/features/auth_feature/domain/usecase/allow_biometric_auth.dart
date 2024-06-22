import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class AllowBiometricAuth {
  Future<Either<Failure, bool>> call(bool value);
}

class AllowBiometricAuthImpl implements AllowBiometricAuth {
  AllowBiometricAuthImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, bool>> call(bool value) async =>
      await authRepository.allowBiometricAuth(value);
}
