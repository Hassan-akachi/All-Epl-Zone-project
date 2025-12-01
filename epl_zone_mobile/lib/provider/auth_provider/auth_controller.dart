// lib/features/auth/controllers/auth_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../core/network/responses/network_response.dart';
import '../../core/network/service/auth_service.dart';
import 'auth_provider.dart';


// Auth controller provider
final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  AuthController(this._authService) : super(const AsyncValue.data(null));

  Future<String?> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    state = const AsyncValue.loading();

    final response = await _authService.register(
      username: username,
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );

    switch (response) {
      case NetworkSuccess():
        state = const AsyncValue.data(null);
        return null;

      case NetworkFailure(message: final msg):
        state = AsyncValue.error(msg, StackTrace.current);
        return msg;

      case NetworkException(message: final msg):
        state = AsyncValue.error(msg, StackTrace.current);
        return msg;
    }
  }


// Future<String?> login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final response = await _authService.login(
      email: email,
      password: password,
    );

    switch (response) {
      case NetworkSuccess():
        state = const AsyncValue.data(null);
        return null;

      case NetworkFailure(message: final msg):
        state = AsyncValue.error(msg, StackTrace.current);
        return msg;

      case NetworkException(message: final msg):
        state = AsyncValue.error(msg, StackTrace.current);
        return msg;
    }
  }



  //  Future<String?> signInWithGoogle()
  Future<String?> signInWithGoogle() async {
    state = const AsyncValue.loading();

    final response = await _authService.signInWithGoogle();

    switch (response) {
      case NetworkSuccess():
        state = const AsyncValue.data(null);
        return null;

      case NetworkFailure(message: final msg):
        state = AsyncValue.error(msg, StackTrace.current);
        return msg;

      case NetworkException(message: final msg):
        state = AsyncValue.error(msg, StackTrace.current);
        return msg;
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}