// lib/features/auth/providers/auth_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/network_interface.dart';
import '../../core/network/datasource/user_network_datasource.dart';
import '../../core/network/network_client.dart';
import '../../core/network/responses/network_response.dart';
import '../../core/network/service/auth_service.dart';


// Network client provider
final networkClientProvider = Provider<NetworkInterface>((ref) {
  return NetworkClient();
});

// User network datasource provider
final userNetworkProvider = Provider<UserNetworkDataSource>((ref) {
  final networkClient = ref.watch(networkClientProvider);
  return UserNetworkDataSource(networkClient);
});

// Google Sign In provider
final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    clientId: '353577808068-u6l6fhsjut5mmqu8sim7rmcrv16o31ln.apps.googleusercontent.com',
    scopes: ['openid', 'email', 'profile'],
  );
});

// Shared Preferences provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main()');
});

// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  final userNetwork = ref.watch(userNetworkProvider);
  final googleSignIn = ref.watch(googleSignInProvider);
  final prefs = ref.watch(sharedPreferencesProvider);

  return AuthService(
    userNetwork: userNetwork,
    googleSignIn: googleSignIn,
    prefs: prefs,
  );
});

// Auth state provider
final authStateProvider = StreamProvider<bool>((ref) async* {
  final authService = ref.watch(authServiceProvider);
  yield await authService.isLoggedIn();

  // You can add a periodic check or listen to token changes here
  while (true) {
    await Future.delayed(const Duration(seconds: 5));
    yield await authService.isLoggedIn();
  }
});

// Current user provider
final currentUserProvider = FutureProvider((ref) async {
  final authService = ref.watch(authServiceProvider);
  final response = await authService.getUserProfile();

  return switch (response) {
    NetworkSuccess(data: final user) => user,
    NetworkFailure(message: final msg) => throw Exception(msg),
    NetworkException(message: final msg) => throw Exception(msg),
  };
});