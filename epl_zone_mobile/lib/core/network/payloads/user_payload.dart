// lib/core/network/responses/user_response.dart
class UserResponse {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? username;
  final String? phoneNumber;
  final String? profilePicture;

  UserResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.username,
    this.phoneNumber,
    this.profilePicture,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id']?.toString() ?? '',
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      username: json['username'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
    };
  }
}
