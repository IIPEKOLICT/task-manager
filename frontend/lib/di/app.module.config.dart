// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:flutter/material.dart' as _i22;
import 'package:frontend/repositories/auth.repository.dart' as _i27;
import 'package:frontend/repositories/comment.repository.dart' as _i29;
import 'package:frontend/repositories/interceptors/main.interceptor.dart'
    as _i16;
import 'package:frontend/repositories/main.repository.dart' as _i17;
import 'package:frontend/repositories/note.repository.dart' as _i18;
import 'package:frontend/repositories/project.repository.dart' as _i19;
import 'package:frontend/repositories/tag.repository.dart' as _i20;
import 'package:frontend/repositories/task.repository.dart' as _i23;
import 'package:frontend/repositories/user.repository.dart' as _i25;
import 'package:frontend/services/file.service.dart' as _i5;
import 'package:frontend/services/impl/file.service.impl.dart' as _i6;
import 'package:frontend/services/impl/storage.service.impl.dart' as _i11;
import 'package:frontend/services/storage.service.dart' as _i10;
import 'package:frontend/view_models/auth.view_model.dart' as _i28;
import 'package:frontend/view_models/comment.view_model.dart' as _i30;
import 'package:frontend/view_models/login.view_model.dart' as _i31;
import 'package:frontend/view_models/note.view_model.dart' as _i32;
import 'package:frontend/view_models/project.view_model.dart' as _i33;
import 'package:frontend/view_models/register.view_model.dart' as _i34;
import 'package:frontend/view_models/state/auth.state.dart' as _i15;
import 'package:frontend/view_models/state/comment.state.dart' as _i3;
import 'package:frontend/view_models/state/note.state.dart' as _i7;
import 'package:frontend/view_models/state/project.state.dart' as _i8;
import 'package:frontend/view_models/state/tag.state.dart' as _i12;
import 'package:frontend/view_models/state/task.state.dart' as _i13;
import 'package:frontend/view_models/state/user.state.dart' as _i14;
import 'package:frontend/view_models/tag.view_model.dart' as _i21;
import 'package:frontend/view_models/task.view_model.dart' as _i24;
import 'package:frontend/view_models/task_list.view_model.dart' as _i35;
import 'package:frontend/view_models/user.view_model.dart' as _i26;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import 'app.module.dart' as _i36;

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
    gh.lazySingleton<_i3.CommentState>(() => _i3.CommentState());
    gh.lazySingleton<_i4.Dio>(() => appModule.dio);
    gh.lazySingleton<_i5.FileService>(() => _i6.FileServiceImpl());
    gh.lazySingleton<_i7.NoteState>(() => _i7.NoteState());
    gh.lazySingleton<_i8.ProjectState>(() => _i8.ProjectState());
    gh.lazySingletonAsync<_i9.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i10.StorageService>(() => _i11.StorageServiceImpl());
    gh.lazySingleton<_i12.TagState>(() => _i12.TagState());
    gh.lazySingleton<_i13.TaskState>(() => _i13.TaskState());
    gh.lazySingleton<_i14.UserState>(() => _i14.UserState());
    gh.lazySingleton<_i15.AuthState>(
        () => _i15.AuthState(gh<_i10.StorageService>()));
    gh.lazySingleton<_i16.MainInterceptor>(() => _i16.MainInterceptor(
          gh<_i15.AuthState>(),
          gh<_i10.StorageService>(),
        ));
    gh.lazySingleton<_i17.MainRepository>(() => _i17.MainRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.lazySingleton<_i18.NoteRepository>(() => _i18.NoteRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.lazySingleton<_i19.ProjectRepository>(() => _i19.ProjectRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.lazySingleton<_i20.TagRepository>(() => _i20.TagRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.factoryParam<_i21.TagViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i21.TagViewModel(
          context,
          gh<_i12.TagState>(),
          gh<_i8.ProjectState>(),
          gh<_i19.ProjectRepository>(),
          gh<_i20.TagRepository>(),
        ));
    gh.lazySingleton<_i23.TaskRepository>(() => _i23.TaskRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.factoryParam<_i24.TaskViewModel, _i22.BuildContext, bool>((
      context,
      _isEdit,
    ) =>
        _i24.TaskViewModel(
          context,
          _isEdit,
          gh<_i23.TaskRepository>(),
          gh<_i19.ProjectRepository>(),
          gh<_i8.ProjectState>(),
          gh<_i14.UserState>(),
          gh<_i13.TaskState>(),
          gh<_i12.TagState>(),
        ));
    gh.lazySingleton<_i25.UserRepository>(() => _i25.UserRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.factoryParam<_i26.UserViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i26.UserViewModel(
          context,
          gh<_i15.AuthState>(),
          gh<_i25.UserRepository>(),
          gh<_i5.FileService>(),
        ));
    gh.lazySingleton<_i27.AuthRepository>(() => _i27.AuthRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.factoryParam<_i28.AuthViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i28.AuthViewModel(
          context,
          gh<_i15.AuthState>(),
          gh<_i17.MainRepository>(),
          gh<_i27.AuthRepository>(),
        ));
    gh.lazySingleton<_i29.CommentRepository>(() => _i29.CommentRepository(
          gh<_i4.Dio>(),
          gh<_i16.MainInterceptor>(),
        ));
    gh.factoryParam<_i30.CommentViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i30.CommentViewModel(
          context,
          gh<_i3.CommentState>(),
          gh<_i13.TaskState>(),
          gh<_i23.TaskRepository>(),
          gh<_i29.CommentRepository>(),
        ));
    gh.factoryParam<_i31.LoginViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i31.LoginViewModel(
          context,
          gh<_i15.AuthState>(),
          gh<_i27.AuthRepository>(),
        ));
    gh.factoryParam<_i32.NoteViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i32.NoteViewModel(
          context,
          gh<_i7.NoteState>(),
          gh<_i13.TaskState>(),
          gh<_i23.TaskRepository>(),
          gh<_i18.NoteRepository>(),
        ));
    gh.factoryParam<_i33.ProjectViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i33.ProjectViewModel(
          context,
          gh<_i19.ProjectRepository>(),
          gh<_i25.UserRepository>(),
          gh<_i8.ProjectState>(),
          gh<_i14.UserState>(),
          gh<_i12.TagState>(),
          gh<_i15.AuthState>(),
        ));
    gh.factoryParam<_i34.RegisterViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i34.RegisterViewModel(
          context,
          gh<_i15.AuthState>(),
          gh<_i27.AuthRepository>(),
        ));
    gh.factoryParam<_i35.TaskListViewModel, _i22.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i35.TaskListViewModel(
          context,
          gh<_i13.TaskState>(),
          gh<_i8.ProjectState>(),
          gh<_i19.ProjectRepository>(),
          gh<_i23.TaskRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i36.AppModule {}
