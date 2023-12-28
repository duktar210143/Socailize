import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/presentation/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider.autoDispose<AuthViewModel, AuthState>(
  (ref) {
    return AuthViewModel(ref.read(authUseCaseProvider));
  },
);

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState.initialState());

  Future<void> signUpUser(UserEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.signUpUser(user);
    data.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure.error),
      (success) => state.copyWith(isLoading: false, error: null),
    );
  }
}
