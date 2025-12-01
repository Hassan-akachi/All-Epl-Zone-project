class UserProfileResponse {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;

  UserProfileResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
    );
  }
}

class ErrorResponse {
  final String errorMessage;
  final int? statusCode;

  ErrorResponse({
    required this.errorMessage,
    this.statusCode,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      errorMessage: json['errorMessage'] as String? ?? 'Unknown error',
      statusCode: json['statusCode'] as int?,
    );
  }
}
