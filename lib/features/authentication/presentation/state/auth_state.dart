import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final AuthEntity userData;

  AuthState({
    required this.isLoading,
    required this.userData,
    this.error,
  });

  factory AuthState.initialState() {
    return AuthState(
        isLoading: false,
        error: null,
        userData: const AuthEntity(
            username: '',
            firstname: '',
            lastname: '',
            email: '',
            image: '',
            password: ''));
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    AuthEntity? userData,
  }) {
    return AuthState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        userData: userData ?? this.userData);
  }

  @override
  String toString() => 'AuthState(isLoading: $isLoading, error: $error)';
}
