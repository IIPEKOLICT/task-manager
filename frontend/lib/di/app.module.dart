import 'package:dio/dio.dart';
import 'package:frontend/di/app.module.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/environment.dart';

final injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => injector.init();

@module
abstract class AppModule {
  static const int _requestTimeout = 30000;

  @lazySingleton
  Future<SharedPreferences> get sharedPrefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio => Dio(BaseOptions(
        baseUrl: backendUrl,
        receiveTimeout: _requestTimeout,
        connectTimeout: _requestTimeout,
      ));
}
