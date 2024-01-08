
import 'package:discussion_forum/core/common/snackbar/my_snack_bar.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, AuthState>(
  (ref) {
    return AuthViewModel(ref.read(authUseCaseProvider));
  },
);

// manage changing state when a user sign's up
class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState.initialState());

  Future<void> signUpUser(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.signUpUser(user);
    data.fold(
      (failure) =>
          state = state.copyWith(isLoading: false, error: failure.error),
      (success) => state.copyWith(isLoading: false, error: null),
    );
  }

  // manage changing state when a user sign's in
  Future<bool> signInUser(
      BuildContext context, String userName, String password) async {
    bool isLogin = false;
    var data = await _authUseCase.signInUser(userName, password);
    data.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showSnackBar(message: failure.error, context: context, color: Colors.red);
    }, (success) {
      state = state.copyWith(isLoading: false, error: null);
      isLogin = success;
      showSnackBar(message: "login successful", context: context);
    });
    return isLogin;
  }
}
