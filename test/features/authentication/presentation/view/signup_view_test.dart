import 'package:dartz/dartz.dart';
import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/login_useCase.dart';
import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../unit_test/mock_test/login_mock_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late LoginUseCase mockLoginUseCase;

  late AuthEntity userEntity;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();
      mockLoginUseCase = MockLoginUseCase();

      userEntity = const AuthEntity(
        username: 'duktar',
        firstname: 'duktar',
        lastname: 'tamang',
        email: 'duktar@gmail.com',
        password: 'duktar123',
      );
    },
  );

  //passed test case
testWidgets('register view testing', (tester) async {
  // Mock the signup response
  when(mockAuthUsecase.signUpUser(userEntity))
      .thenAnswer((_) async => const Right(true));

  // Build the widget
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(authUseCase: mockAuthUsecase, loginUseCase: mockLoginUseCase),
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRoute.signUpRoute,
        routes: AppRoute.getApplicationRoute(),
      ),
    ),
  );

  // Wait for widgets to settle
  await tester.pumpAndSettle();

  // Enter text in the TextFormField widgets
  await tester.enterText(find.byType(TextFormField).at(0), 'duktar');
  await tester.enterText(find.byType(TextFormField).at(1), 'duktar');
  await tester.enterText(find.byType(TextFormField).at(2), 'tamang');
  await tester.enterText(find.byType(TextFormField).at(3), 'duktar@gmail.com');
  await tester.enterText(find.byType(TextFormField).at(4), 'duktar123');

  // Find the SignUp button and tap it
  final registerButtonFinder = find.descendant(
    of: find.byType(SingleChildScrollView),
    matching: find.widgetWithText(TextButton, 'SignUp'),
  );
  await tester.dragUntilVisible(
    registerButtonFinder,
    find.byType(SingleChildScrollView),
    const Offset(201.4, 574.7),
  );
  await tester.tap(registerButtonFinder);

  // Wait for the SnackBar to appear
  await tester.pumpAndSettle();

await Future.delayed(const Duration(milliseconds: 500));
  // Check if the SnackBar with the correct text is displayed
  expect(find.text('Registered successfully'), findsOneWidget);
  expect(find.text('Sign In'), findsOneWidget);
});

  //failed test case
  // testWidgets('register view but invalid', (tester) async {
  //   when(mockAuthUsecase.signUpUser(userEntity))
  //       .thenAnswer((_) async => Left(Failure(error: 'Invalid registration')));

  //   await tester.pumpWidget(
  //     ProviderScope(
  //       overrides: [
  //         authViewModelProvider.overrideWith(
  //           (ref) => AuthViewModel(mockAuthUsecase),
  //         ),
  //       ],
  //       child: MaterialApp(
  //         initialRoute: AppRoute.registerRoute,
  //         routes: AppRoute.getApplicationRoute(),
  //       ),
  //     ),
  //   );

  //   await tester.pumpAndSettle();

  //   await tester.enterText(find.byType(TextFormField).at(0), 'achyut');

  //   await tester.enterText(
  //       find.byType(TextFormField).at(1), 'achyut@gmail.com');

  //   await tester.enterText(find.byType(TextFormField).at(2), 'achyut123');

  //   await tester.enterText(find.byType(TextFormField).at(3), 'achyut123');

  //   //=========================== Find the register button===========================
  //   final registerButtonFinder =
  //       find.widgetWithText(ElevatedButton, 'REGISTER');

  //   await tester.dragUntilVisible(
  //     registerButtonFinder, // what you want to find
  //     find.byType(SingleChildScrollView), // widget you want to scroll
  //     const Offset(201.4, 574.7), // delta to move
  //   );

  //   await tester.tap(registerButtonFinder);

  //   await tester.pump();

  //   // Check weather the snackbar is displayed or not
  //   expect(find.widgetWithText(SnackBar, 'Registered successfully'),
  //       findsOneWidget);
  // });
}
