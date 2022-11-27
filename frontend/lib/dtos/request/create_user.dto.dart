class CreateUserDto {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const CreateUserDto(this.email, this.password, this.firstName, this.lastName);

  Map<String, dynamic> get json {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}