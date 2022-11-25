// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:frontend/repositories/auth.repository.dart' as _i7;
import 'package:frontend/repositories/main.repository.dart' as _i5;
import 'package:frontend/viewModels/auth.view_model.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import 'app.module.dart' as _i8;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.AuthViewModel>(() => _i3.AuthViewModel());
    gh.lazySingleton<_i4.Dio>(() => appModule.dio);
    gh.lazySingleton<_i5.MainRepository>(
        () => _i5.MainRepository(gh<_i4.Dio>()));
    gh.lazySingletonAsync<_i6.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i7.AuthRepository>(
        () => _i7.AuthRepository(gh<_i4.Dio>()));
    return this;
  }
}

class _$AppModule extends _i8.AppModule {}
