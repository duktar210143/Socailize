import 'package:discussion_forum/features/authentication/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("login view tests", () {
    testWidgets('check for button named signin', (tester) async {
      await tester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: LoginView())));
      await tester.pumpAndSettle();
      expect(find.text('login'), findsOneWidget);
    });

    testWidgets('Renders email and password text fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: LoginView())));

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('Renders signup text', (WidgetTester tester) async {
      await tester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: LoginView())));

      expect(find.text("SignUp"), findsOneWidget);
    });

  });
}
