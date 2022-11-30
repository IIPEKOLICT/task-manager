// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter/material.dart' as _i11;
import 'package:frontend/repositories/auth.repository.dart' as _i9;
import 'package:frontend/repositories/main.repository.dart' as _i8;
import 'package:frontend/services/impl/storage.service.impl.dart' as _i6;
import 'package:frontend/services/storage.service.dart' as _i5;
import 'package:frontend/view_models/auth.view_model.dart' as _i10;
import 'package:frontend/view_models/login.view_model.dart' as _i12;
import 'package:frontend/view_models/register.view_model.dart' as _i13;
import 'package:frontend/view_models/state/auth.state.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

import 'app.module.dart' as _i14;

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
    gh.lazySingleton<_i3.Dio>(() => appModule.dio);
    gh.lazySingletonAsync<_i4.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i5.StorageService>(() => _i6.StorageServiceImpl());
    gh.lazySingleton<_i7.AuthState>(
        () => _i7.AuthState(gh<_i5.StorageService>()));
    gh.lazySingleton<_i8.MainRepository>(() => _i8.MainRepository(
          gh<_i3.Dio>(),
          gh<_i7.AuthState>(),
        ));
    gh.lazySingleton<_i9.AuthRepository>(() => _i9.AuthRepository(
          gh<_i3.Dio>(),
          gh<_i7.AuthState>(),
        ));
    gh.factoryParam<_i10.AuthViewModel, _i11.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i10.AuthViewModel(
          context,
          gh<_i7.AuthState>(),
          gh<_i8.MainRepository>(),
          gh<_i9.AuthRepository>(),
        ));
    gh.factoryParam<_i12.LoginViewModel, _i11.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i12.LoginViewModel(
          context,
          gh<_i7.AuthState>(),
          gh<_i9.AuthRepository>(),
        ));
    gh.factoryParam<_i13.RegisterViewModel, _i11.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i13.RegisterViewModel(
          context,
          gh<_i7.AuthState>(),
          gh<_i9.AuthRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i14.AppModule {}
