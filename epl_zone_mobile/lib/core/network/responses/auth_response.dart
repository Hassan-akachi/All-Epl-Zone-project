// lib/core/network/responses/auth_response.dart
class AuthResponse {
  final String accessToken;
  final String? refreshToken;
  final String? tokenType;

  AuthResponse({
    required this.accessToken,
    this.refreshToken,
    this.tokenType,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String?,
    );
  }
}