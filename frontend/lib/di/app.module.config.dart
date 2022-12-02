// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter/material.dart' as _i12;
import 'package:frontend/models/project.dart' as _i18;
import 'package:frontend/repositories/auth.repository.dart' as _i14;
import 'package:frontend/repositories/main.repository.dart' as _i9;
import 'package:frontend/repositories/project.repository.dart' as _i10;
import 'package:frontend/repositories/user.repository.dart' as _i13;
import 'package:frontend/services/impl/storage.service.impl.dart' as _i7;
import 'package:frontend/services/storage.service.dart' as _i6;
import 'package:frontend/view_models/auth.view_model.dart' as _i15;
import 'package:frontend/view_models/login.view_model.dart' as _i16;
import 'package:frontend/view_models/project.view_model.dart' as _i11;
import 'package:frontend/view_models/project_dialog.view_model.dart' as _i17;
import 'package:frontend/view_models/register.view_model.dart' as _i19;
import 'package:frontend/view_models/state/auth.state.dart' as _i8;
import 'package:frontend/view_models/state/project.state.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import 'app.module.dart' as _i20;

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
    gh.lazySingleton<_i4.ProjectState>(() => _i4.ProjectState());
    gh.lazySingletonAsync<_i5.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i6.StorageService>(() => _i7.StorageServiceImpl());
    gh.lazySingleton<_i8.AuthState>(
        () => _i8.AuthState(gh<_i6.StorageService>()));
    gh.lazySingleton<_i9.MainRepository>(() => _i9.MainRepository(
          gh<_i3.Dio>(),
          gh<_i8.AuthState>(),
        ));
    gh.lazySingleton<_i10.ProjectRepository>(() => _i10.ProjectRepository(
          gh<_i3.Dio>(),
          gh<_i8.AuthState>(),
        ));
    gh.factoryParam<_i11.ProjectViewModel, _i12.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i11.ProjectViewModel(
          context,
          gh<_i10.ProjectRepository>(),
          gh<_i4.ProjectState>(),
        ));
    gh.lazySingleton<_i13.UserRepository>(() => _i13.UserRepository(
          gh<_i3.Dio>(),
          gh<_i8.AuthState>(),
        ));
    gh.lazySingleton<_i14.AuthRepository>(() => _i14.AuthRepository(
          gh<_i3.Dio>(),
          gh<_i8.AuthState>(),
        ));
    gh.factoryParam<_i15.AuthViewModel, _i12.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i15.AuthViewModel(
          context,
          gh<_i8.AuthState>(),
          gh<_i9.MainRepository>(),
          gh<_i14.AuthRepository>(),
        ));
    gh.factoryParam<_i16.LoginViewModel, _i12.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i16.LoginViewModel(
          context,
          gh<_i8.AuthState>(),
          gh<_i14.AuthRepository>(),
        ));
    gh.factoryParam<_i17.ProjectDialogViewModel, _i12.BuildContext,
        _i18.Project?>((
      context,
      _project,
    ) =>
        _i17.ProjectDialogViewModel(
          context,
          _project,
          gh<_i10.ProjectRepository>(),
          gh<_i13.UserRepository>(),
          gh<_i4.ProjectState>(),
          gh<_i8.AuthState>(),
        ));
    gh.factoryParam<_i19.RegisterViewModel, _i12.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i19.RegisterViewModel(
          context,
          gh<_i8.AuthState>(),
          gh<_i14.AuthRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i20.AppModule {}
