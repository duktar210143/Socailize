import 'package:dartz/dartz.dart';
import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/login_useCase.dart';
import 'package:discussion_forum/features/authentication/presentation/state/auth_state.dart';
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

  test('login test using valid username and password', () async {
    const authEntity = AuthEntity(
        username: 'duktar',
        firstname: 'duktar',
        lastname: 'duktar',
        email: 'duktar',
        password: 'duktar');

    final authData = AuthData(userData: authEntity, token: "mocktoken");
    when(mockLoginUseCase.login("duktar", 'tamang123'))
        .thenAnswer((_) => Future.value(Right(authData)));

    // call the login function
    await container
        .read(authViewModelProvider.notifier)
        .signInUser(mockBuildContext, 'duktar', 'tamang123');
    final authState = container.read(authViewModelProvider);
    // check the results
    expect(authState.error, isNull);
  });

  tearDownAll(() {
    container.dispose();
  });
}
