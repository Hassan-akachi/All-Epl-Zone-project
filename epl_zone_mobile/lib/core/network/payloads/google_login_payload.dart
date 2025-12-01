// lib/core/network/payloads/google_login_payload.dart
class GoogleLoginPayload {
  final String idToken;

  GoogleLoginPayload({required this.idToken});

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
    };
  }
}