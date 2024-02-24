import 'dart:io';

import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/common/snackbar/my_snack_bar.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/login_useCase.dart';
import 'package:discussion_forum/features/authentication/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider =
    StateNotifierProvider.autoDispose<AuthViewModel, AuthState>(
  (ref) {
    return AuthViewModel(
        authUseCase: ref.read(authUseCaseProvider),
        loginUseCase: ref.read(loginUseCaseProvider));
  },
);

// manage changing state when a user sign's up
class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  final LoginUseCase loginUseCase;

  AuthViewModel({required this.authUseCase, required this.loginUseCase})
      : super(AuthState.initialState()) {
    getUserData();
  }

  Future<void> signUpUser(BuildContext context, AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.signUpUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            color: Colors.red, message: failure.error, context: context);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "registered successful", context: context);
        // Emit a new state with success information if needed
      },
    );
  }

  Future<void> uploadprofile(File image) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.uploadProfile(image);
    data.fold((failure) {
      return state = state.copyWith(isLoading: false, error: failure.error);
    }, (user) {
      return state = state.copyWith(isLoading: false,userData: user);
    });
  }

  // manage changing state when a user sign's in
  Future<bool> signInUser(
      BuildContext context, String userName, String password) async {
    bool isLogin = false;
    var data = await loginUseCase.login(userName, password);
    data.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showSnackBar(message: failure.error, context: context, color: Colors.red);
    }, (success) {
      print("login Success data" + "${success.userData}");
      state = state.copyWith(
          isLoading: false, error: null, userData: success.userData);
      isLogin = true;
      // showSnackBar(message: "login successful", context: context);
      // Navigator.pushNamed(context, AppRoute.dashboard);
    });
    return isLogin;
  }

  void getUserData() {
    state = state.copyWith(isLoading: true);
    authUseCase.getUserData().then((value) {
      value.fold((failure) {
        return state = state.copyWith(isLoading: false);
      }, (authEntity) {
        return state = state.copyWith(isLoading: false, userData: authEntity);
      });
    });
  }
}
