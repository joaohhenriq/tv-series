import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class CheckPin {
  Future<Either<Failure, bool>> call(String pin);
}

class CheckPinImpl implements CheckPin {
  CheckPinImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, bool>> call(String pin) async =>
      authRepository.checkPin(pin);
}
