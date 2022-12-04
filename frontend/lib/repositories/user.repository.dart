import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/models/user.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import '../dtos/response/delete.dto.dart';
import 'base/base.repository.dart';

@LazySingleton()
class UserRepository extends BaseRepository {
  UserRepository(super.httpClient, super.authState);

  @override
  String get endpoint => 'users';

  Future<List<User>> getAll() async {
    return (await get<List>()).map((json) => User.fromJson(json)).toList();
  }

  Future<User> getById(String id) async {
    return User.fromJson(await get<Map<String, dynamic>>(path: id));
  }

  Future<User> updateCredentials(String id, String email, String password) async {
    return User.fromJson(
      await patch<Map<String, dynamic>>(
        path: '$id/credentials',
        body: {
          'email': email.isNotEmpty ? email : null,
          'password': password.isNotEmpty ? password : null,
        },
      ),
    );
  }

  Future<User> updateInfo(String id, String firstName, String lastName) async {
    return User.fromJson(
      await patch<Map<String, dynamic>>(
        path: '$id/info',
        body: {'firstName': firstName, 'lastName': lastName},
      ),
    );
  }

  Future<User> updatePicture(String id, File file) async {
    final formData = FormData.fromMap({
      'picture': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      )
    });

    return User.fromJson(await patch<Map<String, dynamic>>(path: '$id/picture', body: formData));
  }

  Future<User> deletePicture(String id) async {
    return User.fromJson(await delete<Map<String, dynamic>>(path: '$id/picture'));
  }

  Future<String> deleteById(String id) async {
    return DeleteDto.fromJson(await delete<Map<String, dynamic>>(path: id)).id;
  }
}
