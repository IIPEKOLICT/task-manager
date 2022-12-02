// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter/material.dart' as _i14;
import 'package:frontend/models/project.dart' as _i20;
import 'package:frontend/repositories/auth.repository.dart' as _i16;
import 'package:frontend/repositories/main.repository.dart' as _i11;
import 'package:frontend/repositories/project.repository.dart' as _i12;
import 'package:frontend/repositories/user.repository.dart' as _i15;
import 'package:frontend/services/file.service.dart' as _i4;
import 'package:frontend/services/impl/file.service.impl.dart' as _i5;
import 'package:frontend/services/impl/storage.service.impl.dart' as _i9;
import 'package:frontend/services/storage.service.dart' as _i8;
import 'package:frontend/view_models/auth.view_model.dart' as _i17;
import 'package:frontend/view_models/login.view_model.dart' as _i18;
import 'package:frontend/view_models/project.view_model.dart' as _i13;
import 'package:frontend/view_models/project_dialog.view_model.dart' as _i19;
import 'package:frontend/view_models/register.view_model.dart' as _i21;
import 'package:frontend/view_models/state/auth.state.dart' as _i10;
import 'package:frontend/view_models/state/project.state.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'app.module.dart' as _i22;

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
    gh.lazySingleton<_i4.FileService>(() => _i5.FileServiceImpl());
    gh.lazySingleton<_i6.ProjectState>(() => _i6.ProjectState());
    gh.lazySingletonAsync<_i7.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i8.StorageService>(() => _i9.StorageServiceImpl());
    gh.lazySingleton<_i10.AuthState>(
        () => _i10.AuthState(gh<_i8.StorageService>()));
    gh.lazySingleton<_i11.MainRepository>(() => _i11.MainRepository(
          gh<_i3.Dio>(),
          gh<_i10.AuthState>(),
        ));
    gh.lazySingleton<_i12.ProjectRepository>(() => _i12.ProjectRepository(
          gh<_i3.Dio>(),
          gh<_i10.AuthState>(),
        ));
    gh.factoryParam<_i13.ProjectViewModel, _i14.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i13.ProjectViewModel(
          context,
          gh<_i12.ProjectRepository>(),
          gh<_i6.ProjectState>(),
        ));
    gh.lazySingleton<_i15.UserRepository>(() => _i15.UserRepository(
          gh<_i3.Dio>(),
          gh<_i10.AuthState>(),
        ));
    gh.lazySingleton<_i16.AuthRepository>(() => _i16.AuthRepository(
          gh<_i3.Dio>(),
          gh<_i10.AuthState>(),
        ));
    gh.factoryParam<_i17.AuthViewModel, _i14.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i17.AuthViewModel(
          context,
          gh<_i10.AuthState>(),
          gh<_i11.MainRepository>(),
          gh<_i16.AuthRepository>(),
        ));
    gh.factoryParam<_i18.LoginViewModel, _i14.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i18.LoginViewModel(
          context,
          gh<_i10.AuthState>(),
          gh<_i16.AuthRepository>(),
        ));
    gh.factoryParam<_i19.ProjectDialogViewModel, _i14.BuildContext,
        _i20.Project?>((
      context,
      _project,
    ) =>
        _i19.ProjectDialogViewModel(
          context,
          _project,
          gh<_i12.ProjectRepository>(),
          gh<_i15.UserRepository>(),
          gh<_i6.ProjectState>(),
          gh<_i10.AuthState>(),
        ));
    gh.factoryParam<_i21.RegisterViewModel, _i14.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i21.RegisterViewModel(
          context,
          gh<_i10.AuthState>(),
          gh<_i16.AuthRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i22.AppModule {}
