class RegisterPayload {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  RegisterPayload({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }
}