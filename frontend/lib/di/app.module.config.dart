// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:flutter/material.dart' as _i27;
import 'package:frontend/repositories/attachment.repository.dart' as _i34;
import 'package:frontend/repositories/auth.repository.dart' as _i36;
import 'package:frontend/repositories/comment.repository.dart' as _i38;
import 'package:frontend/repositories/interceptors/main.interceptor.dart'
    as _i21;
import 'package:frontend/repositories/main.repository.dart' as _i22;
import 'package:frontend/repositories/note.repository.dart' as _i23;
import 'package:frontend/repositories/project.repository.dart' as _i24;
import 'package:frontend/repositories/tag.repository.dart' as _i25;
import 'package:frontend/repositories/task.repository.dart' as _i28;
import 'package:frontend/repositories/user.repository.dart' as _i30;
import 'package:frontend/repositories/work.repository.dart' as _i32;
import 'package:frontend/services/file.service.dart' as _i7;
import 'package:frontend/services/impl/file.service.impl.dart' as _i8;
import 'package:frontend/services/impl/storage.service.impl.dart' as _i14;
import 'package:frontend/services/platform_specific/impl/desktop_save_file.service.impl.dart'
    as _i5;
import 'package:frontend/services/platform_specific/impl/mobile_save_file.service.impl.dart'
    as _i9;
import 'package:frontend/services/platform_specific/impl/web_save_file.service.impl.dart'
    as _i18;
import 'package:frontend/services/storage.service.dart' as _i13;
import 'package:frontend/view_models/attachment.view_model.dart' as _i35;
import 'package:frontend/view_models/auth.view_model.dart' as _i37;
import 'package:frontend/view_models/comment.view_model.dart' as _i39;
import 'package:frontend/view_models/login.view_model.dart' as _i40;
import 'package:frontend/view_models/note.view_model.dart' as _i41;
import 'package:frontend/view_models/project.view_model.dart' as _i42;
import 'package:frontend/view_models/register.view_model.dart' as _i43;
import 'package:frontend/view_models/state/attachment.state.dart' as _i3;
import 'package:frontend/view_models/state/auth.state.dart' as _i20;
import 'package:frontend/view_models/state/comment.state.dart' as _i4;
import 'package:frontend/view_models/state/note.state.dart' as _i10;
import 'package:frontend/view_models/state/project.state.dart' as _i11;
import 'package:frontend/view_models/state/tag.state.dart' as _i15;
import 'package:frontend/view_models/state/task.state.dart' as _i16;
import 'package:frontend/view_models/state/user.state.dart' as _i17;
import 'package:frontend/view_models/state/work.state.dart' as _i19;
import 'package:frontend/view_models/tag.view_model.dart' as _i26;
import 'package:frontend/view_models/task.view_model.dart' as _i29;
import 'package:frontend/view_models/task_list.view_model.dart' as _i44;
import 'package:frontend/view_models/user.view_model.dart' as _i31;
import 'package:frontend/view_models/work.view_model.dart' as _i33;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import 'app.module.dart' as _i45;

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
    gh.lazySingleton<_i5.DesktopSaveFileServiceImpl>(
        () => _i5.DesktopSaveFileServiceImpl());
    gh.lazySingleton<_i6.Dio>(() => appModule.dio);
    gh.lazySingleton<_i7.FileService>(() => _i8.FileServiceImpl());
    gh.lazySingleton<_i9.MobileSaveFileServiceImpl>(
        () => _i9.MobileSaveFileServiceImpl());
    gh.lazySingleton<_i10.NoteState>(() => _i10.NoteState());
    gh.lazySingleton<_i11.ProjectState>(() => _i11.ProjectState());
    gh.lazySingletonAsync<_i12.SharedPreferences>(() => appModule.sharedPrefs);
    gh.lazySingleton<_i13.StorageService>(() => _i14.StorageServiceImpl());
    gh.lazySingleton<_i15.TagState>(() => _i15.TagState());
    gh.lazySingleton<_i16.TaskState>(() => _i16.TaskState());
    gh.lazySingleton<_i17.UserState>(() => _i17.UserState());
    gh.lazySingleton<_i18.WebSaveFileServiceImpl>(
        () => _i18.WebSaveFileServiceImpl());
    gh.lazySingleton<_i19.WorkState>(() => _i19.WorkState());
    gh.lazySingleton<_i20.AuthState>(
        () => _i20.AuthState(gh<_i13.StorageService>()));
    gh.lazySingleton<_i21.MainInterceptor>(() => _i21.MainInterceptor(
          gh<_i20.AuthState>(),
          gh<_i13.StorageService>(),
        ));
    gh.lazySingleton<_i22.MainRepository>(() => _i22.MainRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.lazySingleton<_i23.NoteRepository>(() => _i23.NoteRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.lazySingleton<_i24.ProjectRepository>(() => _i24.ProjectRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.lazySingleton<_i25.TagRepository>(() => _i25.TagRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.factoryParam<_i26.TagViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i26.TagViewModel(
          context,
          gh<_i15.TagState>(),
          gh<_i11.ProjectState>(),
          gh<_i24.ProjectRepository>(),
          gh<_i25.TagRepository>(),
        ));
    gh.lazySingleton<_i28.TaskRepository>(() => _i28.TaskRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.factoryParam<_i29.TaskViewModel, _i27.BuildContext, bool>((
      context,
      _isEdit,
    ) =>
        _i29.TaskViewModel(
          context,
          _isEdit,
          gh<_i28.TaskRepository>(),
          gh<_i24.ProjectRepository>(),
          gh<_i11.ProjectState>(),
          gh<_i17.UserState>(),
          gh<_i16.TaskState>(),
          gh<_i15.TagState>(),
        ));
    gh.lazySingleton<_i30.UserRepository>(() => _i30.UserRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.factoryParam<_i31.UserViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i31.UserViewModel(
          context,
          gh<_i20.AuthState>(),
          gh<_i30.UserRepository>(),
          gh<_i7.FileService>(),
        ));
    gh.lazySingleton<_i32.WorkRepository>(() => _i32.WorkRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.factoryParam<_i33.WorkViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i33.WorkViewModel(
          context,
          gh<_i19.WorkState>(),
          gh<_i16.TaskState>(),
          gh<_i28.TaskRepository>(),
          gh<_i32.WorkRepository>(),
        ));
    gh.lazySingleton<_i34.AttachmentRepository>(() => _i34.AttachmentRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.factoryParam<_i35.AttachmentViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i35.AttachmentViewModel(
          context,
          gh<_i3.AttachmentState>(),
          gh<_i16.TaskState>(),
          gh<_i28.TaskRepository>(),
          gh<_i34.AttachmentRepository>(),
          gh<_i7.FileService>(),
        ));
    gh.lazySingleton<_i36.AuthRepository>(() => _i36.AuthRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.factoryParam<_i37.AuthViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i37.AuthViewModel(
          context,
          gh<_i20.AuthState>(),
          gh<_i22.MainRepository>(),
          gh<_i36.AuthRepository>(),
        ));
    gh.lazySingleton<_i38.CommentRepository>(() => _i38.CommentRepository(
          gh<_i6.Dio>(),
          gh<_i21.MainInterceptor>(),
        ));
    gh.factoryParam<_i39.CommentViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i39.CommentViewModel(
          context,
          gh<_i4.CommentState>(),
          gh<_i16.TaskState>(),
          gh<_i28.TaskRepository>(),
          gh<_i38.CommentRepository>(),
        ));
    gh.factoryParam<_i40.LoginViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i40.LoginViewModel(
          context,
          gh<_i20.AuthState>(),
          gh<_i36.AuthRepository>(),
        ));
    gh.factoryParam<_i41.NoteViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i41.NoteViewModel(
          context,
          gh<_i10.NoteState>(),
          gh<_i16.TaskState>(),
          gh<_i28.TaskRepository>(),
          gh<_i23.NoteRepository>(),
        ));
    gh.factoryParam<_i42.ProjectViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i42.ProjectViewModel(
          context,
          gh<_i24.ProjectRepository>(),
          gh<_i30.UserRepository>(),
          gh<_i11.ProjectState>(),
          gh<_i17.UserState>(),
          gh<_i15.TagState>(),
          gh<_i20.AuthState>(),
        ));
    gh.factoryParam<_i43.RegisterViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i43.RegisterViewModel(
          context,
          gh<_i20.AuthState>(),
          gh<_i36.AuthRepository>(),
        ));
    gh.factoryParam<_i44.TaskListViewModel, _i27.BuildContext, dynamic>((
      context,
      _,
    ) =>
        _i44.TaskListViewModel(
          context,
          gh<_i16.TaskState>(),
          gh<_i11.ProjectState>(),
          gh<_i24.ProjectRepository>(),
          gh<_i28.TaskRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i45.AppModule {}
