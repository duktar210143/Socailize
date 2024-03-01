import 'package:dartz/dartz.dart';
import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/login_useCase.dart';
import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../unit_test/mock_test/login_mock_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginUseCase>(), MockSpec<AuthUseCase>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  const authEntity = AuthEntity(
      username: 'duktar',
      firstname: 'duktar',
      lastname: 'duktar',
      email: 'duktar',
      password: 'duktar');

  final authData = AuthData(userData: authEntity, token: "mocktoken");
  late LoginUseCase mockLoginUseCase;
  late AuthUseCase mockAuthUseCase;

  late AuthData isLogin;

  setUpAll(() async {
    mockLoginUseCase = MockLoginUseCase();
    mockAuthUseCase = MockAuthUseCase();

// if login successfull returns auth data
    isLogin = authData;
  });

  testWidgets('login view testing', (WidgetTester tester) async {
    when(mockLoginUseCase.login('test', 'tester'))
        .thenAnswer((_) async => Right(isLogin));
    // Stub getUserData here
    when(mockAuthUseCase.getUserData())
        .thenAnswer((_) => Future.value(const Right(authEntity)));

    await tester.pumpWidget(ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith((ref) => AuthViewModel(
              authUseCase: mockAuthUseCase, loginUseCase: mockLoginUseCase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        )));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'test');

    await tester.enterText(find.byType(TextField).at(1), 'tester');

    await tester.tap(
      find.widgetWithText(TextButton, 'login'),
    );

    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3));

    expect(find.text('List of Questions'), findsOneWidget);
  });
}
