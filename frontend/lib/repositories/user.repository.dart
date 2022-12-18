import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/repositories/base/read_delete.repository.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

import 'base/base.repository.dart';

@LazySingleton()
class UserRepository extends BaseRepository with ReadDeleteRepository<User> {
  UserRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'users';

  @override
  User Function(Map<String, dynamic> p1) get convertResponse => User.fromJson;

  Future<List<User>> getAll() async {
    return (await get<List>()).map((json) => convertResponse(json)).toList();
  }

  Future<User> updateCredentials(String id, String email, String password) async {
    return convertResponse(
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
    return convertResponse(
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

    return convertResponse(await patch<Map<String, dynamic>>(path: '$id/picture', body: formData));
  }

  Future<User> deletePicture(String id) async {
    return convertResponse(await delete<Map<String, dynamic>>(path: '$id/picture'));
  }
}
