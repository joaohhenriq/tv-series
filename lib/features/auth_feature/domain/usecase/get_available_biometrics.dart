import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class GetAvailableBiometrics {
  Future<Either<Failure, void>> call();
}

class GetAvailableBiometricsImpl implements GetAvailableBiometrics {
  GetAvailableBiometricsImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, void>> call() async =>
      await authRepository.getAvailableBiometrics();
}
