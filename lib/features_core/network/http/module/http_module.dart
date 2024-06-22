import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_series_app/features_core/network/network.dart';

class HttpModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add<HttpNetwork>(
      () => HttpNetworkImpl(client: Dio(), httpInterceptor: i.get()),
    );
  }

  @override
  void binds(Injector i) {
    i.add<HttpInterceptor>(HttpInterceptor.new);
  }
}
