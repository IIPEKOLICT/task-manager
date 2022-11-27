// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:flutter/material.dart' as _i5;
import 'package:frontend/repositories/auth.repository.dart' as _i11;
import 'package:frontend/repositories/main.repository.dart' as _i12;
import 'package:frontend/services/storage.service.dart' as _i10;
import 'package:frontend/view_models/auth.view_model.dart' as _i4;
import 'package:frontend/view_models/login.view_model.dart' as _i7;
import 'package:frontend/view_models/register.view_model.dart' as _i8;
import 'package:frontend/view_models/state/auth.state.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import 'app.module.dart' as _i13;

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
    gh.lazySingleton<_i3.AuthState>(() => _i3.AuthState());
    gh.factoryParam<_i4.AuthViewModel, _i5.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i4.AuthViewModel(context));
    gh.lazySingleton<_i6.Dio>(() => appModule.dio);
    gh.factoryParam<_i7.LoginViewModel, _i5.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i7.LoginViewModel(context));
    gh.factoryParam<_i8.RegisterViewModel, _i5.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i8.RegisterViewModel(context));
    gh.lazySingletonAsync<_i9.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i10.StorageService>(() => _i10.StorageService());
    gh.lazySingleton<_i11.AuthRepository>(() => _i11.AuthRepository(
          gh<_i6.Dio>(),
          gh<_i10.StorageService>(),
        ));
    gh.lazySingleton<_i12.MainRepository>(() => _i12.MainRepository(
          gh<_i6.Dio>(),
          gh<_i10.StorageService>(),
        ));
    return this;
  }
}

class _$AppModule extends _i13.AppModule {}
