class User {
  String id;
  String email;
  String firstName;
  String lastName;
  String? profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
      createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'createdAt': createdAt?.toString(),
      'updatedAt': updatedAt?.toString()
    };
  }
}