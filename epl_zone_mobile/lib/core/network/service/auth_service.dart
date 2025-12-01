// lib/features/auth/service/auth_service.dart

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasource/user_network_datasource.dart';
import '../payloads/google_login_payload.dart';
import '../payloads/login_payload.dart';
import '../payloads/register_payload.dart';
import '../responses/auth_response.dart';
import '../responses/network_response.dart';
import '../responses/user_profile_response.dart';

class AuthService {
  final UserNetworkDataSource _userNetwork;
  final GoogleSignIn _googleSignIn;
  final SharedPreferences _prefs;

  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  AuthService({
    required UserNetworkDataSource userNetwork,
    required GoogleSignIn googleSignIn,
    required SharedPreferences prefs,
  })  : _userNetwork = userNetwork,
        _googleSignIn = googleSignIn,
        _prefs = prefs;

  // Register with email and password
  Future<NetworkResponse<AuthResponse>> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    final payload = RegisterPayload(
      username: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    final response = await _userNetwork.register(payload);

    if (response is NetworkSuccess<AuthResponse>) {
      await _saveTokens(
        accessToken: response.data.accessToken,
        refreshToken: response.data.refreshToken,
      );
    }

    return response;
  }

  // Login with email and password
  Future<NetworkResponse<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    final payload = LoginPayload(email: email, password: password);

    final response = await _userNetwork.login(payload);

    if (response is NetworkSuccess<AuthResponse>) {
      await _saveTokens(
        accessToken: response.data.accessToken,
        refreshToken: response.data.refreshToken,
      );
    }

    return response;
  }

  // Google Sign In
  Future<NetworkResponse<AuthResponse>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return const NetworkFailure(
          'Google sign in was cancelled',
        );
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        return const NetworkFailure(
           'Failed to get ID token from Google',
        );
      }

      final payload = GoogleLoginPayload(idToken: idToken);
      final response = await _userNetwork.googleLogin(payload);

      if (response is NetworkSuccess<AuthResponse>) {
        await _saveTokens(
          accessToken: response.data.accessToken,
          refreshToken: response.data.refreshToken,
        );
      }

      return response;
    } catch (e) {
      return NetworkException(
        message: 'Google sign in failed',
        exception: e,
      );
    }
  }

  // Get user profile
  Future<NetworkResponse<UserProfileResponse>> getUserProfile() async {
    final token = await getAccessToken();

    if (token == null) {
      return const NetworkFailure(
         'No authentication token found',
      );
    }

    return await _userNetwork.getProfile(token);
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _clearTokens();
  }

  // Token management
  Future<void> _saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _prefs.setString(_authTokenKey, accessToken);
    if (refreshToken != null) {
      await _prefs.setString(_refreshTokenKey, refreshToken);
    }
  }

  Future<String?> getAccessToken() async {
    return _prefs.getString(_authTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey);
  }

  Future<void> _clearTokens() async {
    await _prefs.remove(_authTokenKey);
    await _prefs.remove(_refreshTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }
}