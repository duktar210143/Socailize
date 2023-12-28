import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final UserEntity? user;

  AuthState({
    required this.isLoading,
    this.error,
    required this.user,
  });

  factory AuthState.initialState() {
    return AuthState(isLoading: false, user: null, error: null);
  }

  AuthState copyWith({
    bool? isLoading,
    UserEntity? user,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading, 
      user: user??  this.user,
      error: error?? this.error);
  }

   @override
  String toString() =>
      'AuthState(isLoading: $isLoading,user: $user, error: $error)';
}
