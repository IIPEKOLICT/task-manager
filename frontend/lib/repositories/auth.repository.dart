import 'package:injectable/injectable.dart';

import '../dtos/request/create_user.dto.dart';
import '../dtos/response/auth.dto.dart';
import 'base/base.repository.dart';

@LazySingleton()
class AuthRepository extends BaseRepository {
  AuthRepository(super.httpClient, super.mainInterceptor);

  @override
  String get endpoint => 'auth';

  Future<AuthDto> refreshToken() async {
    return AuthDto.fromJSON(await post<Map<String, dynamic>>(path: 'refresh'));
  }

  Future<AuthDto> register(CreateUserDto dto) async {
    return AuthDto.fromJSON(await post<Map<String, dynamic>>(path: 'register', body: dto.json));
  }

  Future<AuthDto> login(String email, String password) async {
    return AuthDto.fromJSON(
        await post<Map<String, dynamic>>(path: 'login', body: {'email': email, 'password': password}));
  }
}
