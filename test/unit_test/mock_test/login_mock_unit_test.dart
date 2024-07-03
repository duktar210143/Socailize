import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/login_usecase.dart';
import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_mock_unit_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthUseCase>(),
    MockSpec<BuildContext>(),
    MockSpec<LoginUseCase>(),
  ],
)
void main() {
  group("auth mock unit tests", () {
    late AuthUseCase mockAuthUseCase;
    late LoginUseCase mockLoginUseCase;
    late BuildContext mockBuildContext;
    late ProviderContainer container;

    setUpAll(() {
      mockAuthUseCase = MockAuthUseCase();
      mockBuildContext = MockBuildContext();
      mockLoginUseCase = MockLoginUseCase();
      container = ProviderContainer(overrides: [
        authViewModelProvider.overrideWith((ref) => AuthViewModel(
            authUseCase: mockAuthUseCase, loginUseCase: mockLoginUseCase))
      ]);
    });

    const authEntity = AuthEntity(
        username: 'duktar',
        firstname: 'duktar',
        lastname: 'duktar',
        email: 'duktar',
        password: 'tamang123');

    test('login test using valid username and password', () async {
      final authData = AuthData(userData: authEntity, token: "mocktoken");
      when(mockLoginUseCase.login("duktar", 'tamang123'))
          .thenAnswer((_) => Future.value(Right(authData)));

      // Stub getUserData here
      when(mockAuthUseCase.getUserData())
          .thenAnswer((_) => Future.value(const Right(authEntity)));

      // call the login function
      await container
          .read(authViewModelProvider.notifier)
          .signInUser(mockBuildContext, 'duktar', 'tamang123');
      final authState = container.read(authViewModelProvider);
      // check the results
      expect(authState.error, isNull);
    });

    test('login test using invalid username and password', () async {
      // Mock the login method to return an error
      when(mockLoginUseCase.login("invalid_username", 'invalid_password'))
          .thenAnswer(
              (_) => Future.value(Left(Failure(error: "invalid credentials"))));

      // Stub getUserData here
      when(mockAuthUseCase.getUserData())
          .thenAnswer((_) => Future.value(const Right(authEntity)));

      // Call the login function with invalid credentials
      await container
          .read(authViewModelProvider.notifier)
          .signInUser(mockBuildContext, 'invalid_username', 'invalid_password');
      final authState = container.read(authViewModelProvider);
      // Check that an error is set in the state
      expect(authState.error, "invalid credentials");
    });

    tearDownAll(() {
      container.dispose();
    });
  });
}
