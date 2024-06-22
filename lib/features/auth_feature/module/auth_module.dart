import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:tv_series_app/features/auth_feature/auth_feature.dart';
import 'package:tv_series_app/features/home_feature/home_feature.dart';
import 'package:tv_series_app/features_core/auth/auth.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [PinModule(), BiometricModule()];

  @override
  void binds(Injector i) {
    // data sources
    i.add<AuthPinDataSource>(() => AuthPinDataSourceImpl(i.get()));
    i.add<AuthBiometricDataSource>(() => AuthBiometricDataSourceImpl(i.get()));

    // repositories
    i.add<AuthRepository>(() => AuthRepositoryImpl(
          datasource: i.get(),
          biometricDataSource: i.get(),
        ));

    // use cases
    i.add<CheckPin>(() => CheckPinImpl(i.get()));
    i.add<IsPinSet>(() => IsPinSetImpl(i.get()));
    i.add<SetPin>(() => SetPinImpl(i.get()));
    i.add<AllowBiometricAuth>(() => AllowBiometricAuthImpl(i.get()));
    i.add<IsBiometricAuthAllowed>(() => IsBiometricAuthAllowedImpl(i.get()));
    i.add<AuthenticateBiometric>(() => AuthenticateBiometricImpl(i.get()));
    i.add<GetAvailableBiometrics>(() => GetAvailableBiometricsImpl(i.get()));
    i.add<IsBiometricLoginForDeviceSupported>(
        () => IsBiometricLoginForDeviceSupportedImpl(i.get()));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      AuthRoutes.authRoute,
      child: (_) => ChangeNotifierProvider(
        create: (_) => AuthState(),
        child: AuthPage(
          isPinSet: Modular.get(),
          setPin: Modular.get(),
          checkPin: Modular.get(),
          allowBiometricAuth: Modular.get(),
          isBiometricAuthAllowed: Modular.get(),
          authenticateBiometric: Modular.get(),
          getAvailableBiometrics: Modular.get(),
          isBiometricLoginForDeviceSupported: Modular.get(),
        ),
      ),
    );
    r.module(HomeRoutes.moduleRoute, module: HomeModule());
  }
}
