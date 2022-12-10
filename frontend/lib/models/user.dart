import 'package:frontend/models/base/base_entity.dart';

class User extends BaseEntity {
  String email;
  String firstName;
  String lastName;
  String? profilePicture;

  User({
    super.id,
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.profilePicture,
    super.createdAt,
    super.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
    );
  }

  String get username {
    return '$firstName $lastName';
  }

  String get fullName {
    return '$firstName $lastName ($email)';
  }
}
