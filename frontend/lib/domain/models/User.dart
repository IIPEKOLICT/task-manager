class User {
  String _id;
  String email;
  String firstName;
  String lastName;
  String? profilePicture;
  DateTime createdAt;
  DateTime? updatedAt;

  User(
    this._id,
    {
      this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.profilePicture,
      required this.createdAt,
      this.updatedAt,
    });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['_id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt?.toString()
    };
  }
}