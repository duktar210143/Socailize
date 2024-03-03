import 'package:dartz/dartz.dart';
import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/auth_usecase.dart';
import 'package:discussion_forum/features/authentication/domain/use_case/login_usecase.dart';
import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../unit_test/mock_test/login_mock_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late LoginUseCase mockLoginUseCase;

  late AuthEntity userEntity;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();
      mockLoginUseCase = MockLoginUseCase();

      userEntity = const AuthEntity(
        firstname: 'duktar',
        lastname: 'tamang',
        email: 'duktar@gmail.com',
        username: 'duktar12',
        password: 'duktar123',
      );
    },
  );

  //passed test case
  testWidgets('register view testing', (tester) async {
    // Mock the signup response
    when(mockAuthUsecase.signUpUser(userEntity))
        .thenAnswer((_) async => const Right(true));
    
     // Stub getUserData here
    when(mockAuthUsecase.getUserData())
        .thenAnswer((_) => Future.value(Right(userEntity)));

    // Build the widget
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
                authUseCase: mockAuthUsecase, loginUseCase: mockLoginUseCase),
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
    await tester.enterText(find.byType(TextFormField).at(1), 'tamang');
    await tester.enterText(find.byType(TextFormField).at(2), 'duktar@gmail.com');
    await tester.enterText(
        find.byType(TextFormField).at(3), 'duktar12');
    await tester.enterText(find.byType(TextFormField).at(4), 'duktar123');
     await tester.enterText(
        find.byType(TextFormField).at(5), 'duktar123');

    // Find the SignUp button and tap it
    final registerButtonFinder = find.widgetWithText(TextButton, 'SignUp');

    await tester.dragUntilVisible(
      registerButtonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(201.4, 574.7), // delta to move
    );

    await tester.tap(registerButtonFinder);

    // Wait for the SnackBar to appear
    await tester.pumpAndSettle();

    // await Future.delayed(const Duration(milliseconds: 500));
    // Check if the SnackBar with the correct text is displayed
    //  Check weather the snackbar is displayed or not
    expect(find.widgetWithText(SnackBar, 'registered successfully'),
        findsOneWidget);
    await Future.delayed(const Duration(seconds: 3));
    expect(find.widgetWithText(TextButton,'login'), findsOneWidget);
  });

  // failed test case
  testWidgets('invalide register view testing', (tester) async {
    when(mockAuthUsecase.signUpUser(userEntity))
        .thenAnswer((_) async => Left(Failure(error: 'Invalid registration')));
    
    // Stub getUserData here
    when(mockAuthUsecase.getUserData())
        .thenAnswer((_) => Future.value(Right(userEntity)));


    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
                authUseCase: mockAuthUsecase, loginUseCase: mockLoginUseCase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.signUpRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();
 // Enter text in the TextFormField widgets
    await tester.enterText(find.byType(TextFormField).at(0), 'duktar');
    await tester.enterText(find.byType(TextFormField).at(1), 'tamang');
    await tester.enterText(find.byType(TextFormField).at(2), 'duktar@gmail.com');
    await tester.enterText(
        find.byType(TextFormField).at(3), 'duktar12');
    await tester.enterText(find.byType(TextFormField).at(4), 'duktar123');
     await tester.enterText(
        find.byType(TextFormField).at(5), 'duktar123');

    //=========================== Find the register button===========================
    final registerButtonFinder =
        find.widgetWithText(TextButton, 'SignUp');

    await tester.dragUntilVisible(
      registerButtonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(201.4, 574.7), // delta to move
    );

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    // Check weather the snackbar is displayed or not
    expect(find.widgetWithText(SnackBar, 'Invalid registration'),
        findsOneWidget);
  });
}
