// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:flutter/material.dart' as _i24;
import 'package:frontend/repositories/attachment.repository.dart' as _i31;
import 'package:frontend/repositories/auth.repository.dart' as _i33;
import 'package:frontend/repositories/comment.repository.dart' as _i35;
import 'package:frontend/repositories/interceptors/main.interceptor.dart'
    as _i18;
import 'package:frontend/repositories/main.repository.dart' as _i19;
import 'package:frontend/repositories/note.repository.dart' as _i20;
import 'package:frontend/repositories/project.repository.dart' as _i21;
import 'package:frontend/repositories/tag.repository.dart' as _i22;
import 'package:frontend/repositories/task.repository.dart' as _i25;
import 'package:frontend/repositories/user.repository.dart' as _i27;
import 'package:frontend/repositories/work.repository.dart' as _i29;
import 'package:frontend/services/file.service.dart' as _i6;
import 'package:frontend/services/impl/file.service.impl.dart' as _i7;
import 'package:frontend/services/impl/storage.service.impl.dart' as _i12;
import 'package:frontend/services/storage.service.dart' as _i11;
import 'package:frontend/view_models/attachment.view_model.dart' as _i32;
import 'package:frontend/view_models/auth.view_model.dart' as _i34;
import 'package:frontend/view_models/comment.view_model.dart' as _i36;
import 'package:frontend/view_models/login.view_model.dart' as _i37;
import 'package:frontend/view_models/note.view_model.dart' as _i38;
import 'package:frontend/view_models/project.view_model.dart' as _i39;
import 'package:frontend/view_models/register.view_model.dart' as _i40;
import 'package:frontend/view_models/state/attachment.state.dart' as _i3;
import 'package:frontend/view_models/state/auth.state.dart' as _i17;
import 'package:frontend/view_models/state/comment.state.dart' as _i4;
import 'package:frontend/view_models/state/note.state.dart' as _i8;
import 'package:frontend/view_models/state/project.state.dart' as _i9;
import 'package:frontend/view_models/state/tag.state.dart' as _i13;
import 'package:frontend/view_models/state/task.state.dart' as _i14;
import 'package:frontend/view_models/state/user.state.dart' as _i15;
import 'package:frontend/view_models/state/work.state.dart' as _i16;
import 'package:frontend/view_models/tag.view_model.dart' as _i23;
import 'package:frontend/view_models/task.view_model.dart' as _i26;
import 'package:frontend/view_models/task_list.view_model.dart' as _i41;
import 'package:frontend/view_models/user.view_model.dart' as _i28;
import 'package:frontend/view_models/work.view_model.dart' as _i30;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import 'app.module.dart' as _i42;

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
    gh.lazySingleton<_i3.AttachmentState>(() => _i3.AttachmentState());
    gh.lazySingleton<_i4.CommentState>(() => _i4.CommentState());
    gh.lazySingleton<_i5.Dio>(() => appModule.dio);
    gh.lazySingleton<_i6.FileService>(() => _i7.FileServiceImpl());
    gh.lazySingleton<_i8.NoteState>(() => _i8.NoteState());
    gh.lazySingleton<_i9.ProjectState>(() => _i9.ProjectState());
    gh.lazySingletonAsync<_i10.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i11.StorageService>(() => _i12.StorageServiceImpl());
    gh.lazySingleton<_i13.TagState>(() => _i13.TagState());
    gh.lazySingleton<_i14.TaskState>(() => _i14.TaskState());
    gh.lazySingleton<_i15.UserState>(() => _i15.UserState());
    gh.lazySingleton<_i16.WorkState>(() => _i16.WorkState());
    gh.lazySingleton<_i17.AuthState>(
        () => _i17.AuthState(gh<_i11.StorageService>()));
    gh.lazySingleton<_i18.MainInterceptor>(() => _i18.MainInterceptor(
          gh<_i17.AuthState>(),
          gh<_i11.StorageService>(),
        ));
    gh.lazySingleton<_i19.MainRepository>(() => _i19.MainRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.lazySingleton<_i20.NoteRepository>(() => _i20.NoteRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.lazySingleton<_i21.ProjectRepository>(() => _i21.ProjectRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.lazySingleton<_i22.TagRepository>(() => _i22.TagRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.factoryParam<_i23.TagViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i23.TagViewModel(
          context,
          gh<_i13.TagState>(),
          gh<_i9.ProjectState>(),
          gh<_i21.ProjectRepository>(),
          gh<_i22.TagRepository>(),
        ));
    gh.lazySingleton<_i25.TaskRepository>(() => _i25.TaskRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.factoryParam<_i26.TaskViewModel, _i24.BuildContext, bool>((
      context,
      _isEdit,
    ) =>
        _i26.TaskViewModel(
          context,
          _isEdit,
          gh<_i25.TaskRepository>(),
          gh<_i21.ProjectRepository>(),
          gh<_i9.ProjectState>(),
          gh<_i15.UserState>(),
          gh<_i14.TaskState>(),
          gh<_i13.TagState>(),
        ));
    gh.lazySingleton<_i27.UserRepository>(() => _i27.UserRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.factoryParam<_i28.UserViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i28.UserViewModel(
          context,
          gh<_i17.AuthState>(),
          gh<_i27.UserRepository>(),
          gh<_i6.FileService>(),
        ));
    gh.lazySingleton<_i29.WorkRepository>(() => _i29.WorkRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.factoryParam<_i30.WorkViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i30.WorkViewModel(
          context,
          gh<_i16.WorkState>(),
          gh<_i14.TaskState>(),
          gh<_i25.TaskRepository>(),
          gh<_i29.WorkRepository>(),
        ));
    gh.lazySingleton<_i31.AttachmentRepository>(() => _i31.AttachmentRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.factoryParam<_i32.AttachmentViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i32.AttachmentViewModel(
          context,
          gh<_i3.AttachmentState>(),
          gh<_i14.TaskState>(),
          gh<_i25.TaskRepository>(),
          gh<_i31.AttachmentRepository>(),
          gh<_i6.FileService>(),
        ));
    gh.lazySingleton<_i33.AuthRepository>(() => _i33.AuthRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.factoryParam<_i34.AuthViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i34.AuthViewModel(
          context,
          gh<_i17.AuthState>(),
          gh<_i19.MainRepository>(),
          gh<_i33.AuthRepository>(),
        ));
    gh.lazySingleton<_i35.CommentRepository>(() => _i35.CommentRepository(
          gh<_i5.Dio>(),
          gh<_i18.MainInterceptor>(),
        ));
    gh.factoryParam<_i36.CommentViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i36.CommentViewModel(
          context,
          gh<_i4.CommentState>(),
          gh<_i14.TaskState>(),
          gh<_i25.TaskRepository>(),
          gh<_i35.CommentRepository>(),
        ));
    gh.factoryParam<_i37.LoginViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i37.LoginViewModel(
          context,
          gh<_i17.AuthState>(),
          gh<_i33.AuthRepository>(),
        ));
    gh.factoryParam<_i38.NoteViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i38.NoteViewModel(
          context,
          gh<_i8.NoteState>(),
          gh<_i14.TaskState>(),
          gh<_i25.TaskRepository>(),
          gh<_i20.NoteRepository>(),
        ));
    gh.factoryParam<_i39.ProjectViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i39.ProjectViewModel(
          context,
          gh<_i21.ProjectRepository>(),
          gh<_i27.UserRepository>(),
          gh<_i9.ProjectState>(),
          gh<_i15.UserState>(),
          gh<_i13.TagState>(),
          gh<_i17.AuthState>(),
        ));
    gh.factoryParam<_i40.RegisterViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i40.RegisterViewModel(
          context,
          gh<_i17.AuthState>(),
          gh<_i33.AuthRepository>(),
        ));
    gh.factoryParam<_i41.TaskListViewModel, _i24.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i41.TaskListViewModel(
          context,
          gh<_i14.TaskState>(),
          gh<_i9.ProjectState>(),
          gh<_i21.ProjectRepository>(),
          gh<_i25.TaskRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i42.AppModule {}
