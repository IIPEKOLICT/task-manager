// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter/material.dart' as _i15;
import 'package:frontend/models/project.dart' as _i25;
import 'package:frontend/models/tag.dart' as _i28;
import 'package:frontend/repositories/auth.repository.dart' as _i20;
import 'package:frontend/repositories/main.repository.dart' as _i12;
import 'package:frontend/repositories/project.repository.dart' as _i13;
import 'package:frontend/repositories/tag.repository.dart' as _i16;
import 'package:frontend/repositories/user.repository.dart' as _i18;
import 'package:frontend/services/file.service.dart' as _i4;
import 'package:frontend/services/impl/file.service.impl.dart' as _i5;
import 'package:frontend/services/impl/storage.service.impl.dart' as _i9;
import 'package:frontend/services/storage.service.dart' as _i8;
import 'package:frontend/view_models/auth.view_model.dart' as _i21;
import 'package:frontend/view_models/dialog/edit_user_dialog.view_model.dart'
    as _i22;
import 'package:frontend/view_models/dialog/project_dialog.view_model.dart'
    as _i24;
import 'package:frontend/view_models/dialog/tag_dialog.view_model.dart' as _i27;
import 'package:frontend/view_models/login.view_model.dart' as _i23;
import 'package:frontend/view_models/project.view_model.dart' as _i14;
import 'package:frontend/view_models/register.view_model.dart' as _i26;
import 'package:frontend/view_models/state/auth.state.dart' as _i11;
import 'package:frontend/view_models/state/project.state.dart' as _i6;
import 'package:frontend/view_models/state/tag.state.dart' as _i10;
import 'package:frontend/view_models/tag.view_model.dart' as _i17;
import 'package:frontend/view_models/user.view_model.dart' as _i19;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'app.module.dart' as _i29;

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
    gh.lazySingleton<_i10.TagState>(() => _i10.TagState());
    gh.lazySingleton<_i11.AuthState>(
        () => _i11.AuthState(gh<_i8.StorageService>()));
    gh.lazySingleton<_i12.MainRepository>(() => _i12.MainRepository(
          gh<_i3.Dio>(),
          gh<_i11.AuthState>(),
        ));
    gh.lazySingleton<_i13.ProjectRepository>(() => _i13.ProjectRepository(
          gh<_i3.Dio>(),
          gh<_i11.AuthState>(),
        ));
    gh.factoryParam<_i14.ProjectViewModel, _i15.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i14.ProjectViewModel(
          context,
          gh<_i13.ProjectRepository>(),
          gh<_i6.ProjectState>(),
        ));
    gh.lazySingleton<_i16.TagRepository>(() => _i16.TagRepository(
          gh<_i3.Dio>(),
          gh<_i11.AuthState>(),
        ));
    gh.factoryParam<_i17.TagViewModel, _i15.BuildContext, String>((
      context,
      _projectId,
    ) =>
        _i17.TagViewModel(
          context,
          _projectId,
          gh<_i10.TagState>(),
          gh<_i6.ProjectState>(),
          gh<_i13.ProjectRepository>(),
          gh<_i16.TagRepository>(),
        ));
    gh.lazySingleton<_i18.UserRepository>(() => _i18.UserRepository(
          gh<_i3.Dio>(),
          gh<_i11.AuthState>(),
        ));
    gh.factoryParam<_i19.UserViewModel, _i15.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i19.UserViewModel(
          context,
          gh<_i11.AuthState>(),
          gh<_i18.UserRepository>(),
          gh<_i4.FileService>(),
        ));
    gh.lazySingleton<_i20.AuthRepository>(() => _i20.AuthRepository(
          gh<_i3.Dio>(),
          gh<_i11.AuthState>(),
        ));
    gh.factoryParam<_i21.AuthViewModel, _i15.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i21.AuthViewModel(
          context,
          gh<_i11.AuthState>(),
          gh<_i12.MainRepository>(),
          gh<_i20.AuthRepository>(),
        ));
    gh.factoryParam<_i22.EditUserDialogViewModel, _i15.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i22.EditUserDialogViewModel(
          context,
          gh<_i18.UserRepository>(),
          gh<_i11.AuthState>(),
        ));
    gh.factoryParam<_i23.LoginViewModel, _i15.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i23.LoginViewModel(
          context,
          gh<_i11.AuthState>(),
          gh<_i20.AuthRepository>(),
        ));
    gh.factoryParam<_i24.ProjectDialogViewModel, _i15.BuildContext,
        _i25.Project?>((
      context,
      _project,
    ) =>
        _i24.ProjectDialogViewModel(
          context,
          _project,
          gh<_i13.ProjectRepository>(),
          gh<_i18.UserRepository>(),
          gh<_i6.ProjectState>(),
          gh<_i11.AuthState>(),
        ));
    gh.factoryParam<_i26.RegisterViewModel, _i15.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i26.RegisterViewModel(
          context,
          gh<_i11.AuthState>(),
          gh<_i20.AuthRepository>(),
        ));
    gh.factoryParam<_i27.TagDialogViewModel, _i15.BuildContext, _i28.Tag?>((
      context,
      _tag,
    ) =>
        _i27.TagDialogViewModel(
          context,
          _tag,
          gh<_i6.ProjectState>(),
          gh<_i16.TagRepository>(),
          gh<_i13.ProjectRepository>(),
          gh<_i10.TagState>(),
        ));
    return this;
  }
}

class _$AppModule extends _i29.AppModule {}