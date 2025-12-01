// // Auth state notifier
// import 'package:flutter_riverpod/legacy.dart';
//
// import '../../core/network/payloads/user_payload.dart';
// import '../../core/network/responses/network_response.dart';
// import '../../core/network/service/auth_service.dart';
// import 'auth_state.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class AuthStateNotifier extends StateNotifier<AuthState> {
//   final AuthService _authService;
//
//   AuthStateNotifier(this._authService) : super(AuthState()) {
//     _checkAuthStatus();
//   }
//
//   Future<void> _checkAuthStatus() async {
//     final isLoggedIn = await _authService.isLoggedIn();
//     if (isLoggedIn) {
//       await _loadUserProfile();
//     }
//   }
//
//   Future<void> _loadUserProfile() async {
//     final response = await _authService.getProfile();
//     if (response is NetworkSuccess<UserResponse>) {
//       state = state.copyWith(
//         isAuthenticated: true,
//         user: response.data,
//       );
//     }
//   }
//
//   Future<bool> register({
//     required String username,
//     required String email,
//     required String password,
//     required String firstName,
//     required String lastName,
//     required String phoneNumber,
//   }) async {
//     state = state.copyWith(isLoading: true, errorMessage: null);
//
//     final response = await _authService.register(
//       username: username,
//       email: email,
//       password: password,
//       firstName: firstName,
//       lastName: lastName,
//       phoneNumber: phoneNumber,
//     );
//
//     if (response is NetworkSuccess) {
//       await _loadUserProfile();
//       state = state.copyWith(isLoading: false, isAuthenticated: true);
//       return true;
//     } else if (response is NetworkFailure) {
//       state = state.copyWith(
//         isLoading: false,
//         errorMessage: response.message,
//       );
//       return false;
//     }
//
//     return false;
//   }
//
//   Future<bool> login({
//     required String email,
//     required String password,
//   }) async {
//     state = state.copyWith(isLoading: true, errorMessage: null);
//
//     final response = await _authService.login(
//       email: email,
//       password: password,
//     );
//
//     if (response is NetworkSuccess) {
//       await _loadUserProfile();
//       state = state.copyWith(isLoading: false, isAuthenticated: true);
//       return true;
//     } else if (response is NetworkFailure) {
//       state = state.copyWith(
//         isLoading: false,
//         errorMessage: response.message,
//       );
//       return false;
//     }
//
//     return false;
//   }
//
//   Future<bool> signInWithGoogle() async {
//     state = state.copyWith(isLoading: true, errorMessage: null);
//
//     final response = await _authService.signInWithGoogle();
//
//     if (response is NetworkSuccess) {
//       await _loadUserProfile();
//       state = state.copyWith(isLoading: false, isAuthenticated: true);
//       return true;
//     } else if (response is NetworkFailure) {
//       state = state.copyWith(
//         isLoading: false,
//         errorMessage: response.message,
//       );
//       return false;
//     }
//
//     return false;
//   }
//
//   Future<void> logout() async {
//     await _authService.logout();
//     state = AuthState();
//   }
// }