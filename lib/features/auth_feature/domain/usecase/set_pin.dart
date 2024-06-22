import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

abstract class SetPin {
  Future<Either<Failure, bool>> call(String pin);
}

class SetPinImpl implements SetPin {
  SetPinImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, bool>> call(String pin) async =>
      authRepository.setPin(pin);
}
