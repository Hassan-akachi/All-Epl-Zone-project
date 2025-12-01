// // Auth state class
// import '../../core/network/payloads/user_payload.dart';
//
// class AuthState {
//   final bool isLoading;
//   final bool isAuthenticated;
//   final String? errorMessage;
//   final UserResponse? user;
//
//   AuthState({
//     this.isLoading = false,
//     this.isAuthenticated = false,
//     this.errorMessage,
//     this.user,
//   });
//
//   AuthState copyWith({
//     bool? isLoading,
//     bool? isAuthenticated,
//     String? errorMessage,
//     UserResponse? user,
//   }) {
//     return AuthState(
//       isLoading: isLoading ?? this.isLoading,
//       isAuthenticated: isAuthenticated ?? this.isAuthenticated,
//       errorMessage: errorMessage,
//       user: user ?? this.user,
//     );
//   }
// }