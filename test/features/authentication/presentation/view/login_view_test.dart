// import 'package:dartz/dartz.dart';
// import 'package:discussion_forum/config/router/app_routes.dart';
// import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart';
// import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
// import 'package:discussion_forum/features/authentication/domain/use_case/login_useCase.dart';
// import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import '../../../../unit_test/mock_test/login_mock_unit_test.mocks.dart';


// @GenerateNiceMocks([
//   MockSpec<LoginUseCase>(),
// ])
// void main() {
//    const authEntity = AuthEntity(
//         username: 'duktar',
//         firstname: 'duktar',
//         lastname: 'duktar',
//         email: 'duktar',
//         password: 'duktar');

//     final authData = AuthData(userData: authEntity, token: "mocktoken");
//   late LoginUseCase mockAuthuseCase;

//   late AuthData isLogin;

//   setUpAll(() async {
//     mockAuthuseCase = MockLoginUseCase();

// // if login successfull returns auth data
//     isLogin = authData;
//   });

//   testWidgets('login view testing', (WidgetTester tester) async {
//     when(mockAuthuseCase.login('duktar', 'duktar123'))
//         .thenAnswer((_) async => Right(isLogin));

//     await tester.pumpWidget(ProviderScope(
//         overrides: [
//           authViewModelProvider
//               .overrideWith((ref) => AuthViewModel(mockAuthuseCase, authUseCase: null, loginUseCase: null)),
//         ],
//         child: MaterialApp(
//           initialRoute: AppRoute.loginRoute,
//           routes: AppRoute.getApplicationRoute(),
//         )));

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextField).at(0), 'duktar');

//     await tester.enterText(find.byType(TextField).at(1), 'duktar123');

//     await tester.tap(
//       find.widgetWithText(ElevatedButton, 'Sign In'),
//     );

//     await tester.pumpAndSettle();

//     expect(find.text('Welcome oopsie'), findsOneWidget);
//   });
// }
