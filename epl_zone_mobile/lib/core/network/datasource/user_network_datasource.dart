import '../../api/api_endpoints.dart';
import '../network_interface.dart';
import '../payloads/google_login_payload.dart';
import '../payloads/login_payload.dart';
import '../payloads/register_payload.dart';
import '../responses/auth_response.dart';
import '../responses/network_response.dart';
import '../responses/user_profile_response.dart';

class UserNetworkDataSource {
  final NetworkInterface _networkClient;

  UserNetworkDataSource(this._networkClient);

  Future<NetworkResponse<AuthResponse>> register(RegisterPayload payload) async {
    return await _networkClient.post<AuthResponse>(
      ApiEndpoints.getAuthUrl(ApiEndpoints.register),
      body: payload.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  Future<NetworkResponse<AuthResponse>> login(LoginPayload payload) async {
    return await _networkClient.post<AuthResponse>(
      ApiEndpoints.getAuthUrl(ApiEndpoints.login),
      body: payload.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  Future<NetworkResponse<AuthResponse>> googleLogin(GoogleLoginPayload payload) async {
    return await _networkClient.post<AuthResponse>(
      ApiEndpoints.getAuthUrl(ApiEndpoints.googleLogin),
      body: payload.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  Future<NetworkResponse<UserProfileResponse>> getProfile(String token) async {
    return await _networkClient.get<UserProfileResponse>(
      ApiEndpoints.getAuthUrl(ApiEndpoints.profile),
      headers: {
        'Authorization': 'Bearer $token',
      },
      fromJson: (json) => UserProfileResponse.fromJson(json),
    );
  }
}