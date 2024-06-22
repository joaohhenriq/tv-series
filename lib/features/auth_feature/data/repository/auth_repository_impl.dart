import 'package:either_dart/either.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features_util/failure/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.datasource,
    required this.biometricDataSource,
  });

  final AuthPinDataSource datasource;
  final AuthBiometricDataSource biometricDataSource;

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

  @override
  Future<Either<Failure, bool>> isBiometricLoginForDeviceSupported() async {
    try {
      final isBiometricLoginForDeviceSupported =
          await biometricDataSource.isBiometricLoginForDeviceSupported();
      return Right(isBiometricLoginForDeviceSupported);
    } on Exception {
      return Left(IsBiometricLoginForDeviceSupportedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> getAvailableBiometrics() async {
    try {
      await biometricDataSource.getAvailableBiometrics();
      return const Right(null);
    } on Exception {
      return Left(GetAvailableBiometricsFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isBiometricAuthAllowed() async {
    try {
      final isBiometricAuthAllowed =
          await biometricDataSource.isBiometricAuthAllowed();
      return Right(isBiometricAuthAllowed);
    } on Exception {
      return Left(IsBiometricAuthAllowedFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> allowBiometricAuth(bool value) async {
    try {
      final isBiometricAuthAllowed =
          await biometricDataSource.allowBiometricAuth(value);
      return Right(isBiometricAuthAllowed);
    } on Exception {
      return Left(AllowBiometricAuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> authenticateBiometric() async {
    try {
      final isBiometricAuthAllowed =
          await biometricDataSource.authenticateBiometric();
      return Right(isBiometricAuthAllowed);
    } on Exception {
      return Left(AuthenticateBiometricFailure());
    }
  }
}
