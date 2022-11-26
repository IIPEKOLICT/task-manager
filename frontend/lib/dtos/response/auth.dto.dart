import '../../models/user.dart';

class AuthDto {
  final String token;
  final User user;

  AuthDto(this.token, this.user);

  factory AuthDto.fromJSON(Map<String, dynamic> json) {
    return AuthDto(json['token'], User.fromJson(json['user']));
  }
}