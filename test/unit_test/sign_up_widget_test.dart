import 'package:discussion_forum/core/common/widgets/text_form_field.dart';
import 'package:discussion_forum/features/authentication/presentation/view/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("SignUpView Tests", () {
    testWidgets('Check for "SignUp" button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignUpView())),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('Renders all text form fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignUpView())),
      );

      expect(
          find.byType(CustomTextFormField), findsNWidgets(6)); // Adjusted to 4
    });

    testWidgets('SignUpView should have a Login button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignUpView())),
      );

      expect(find.text('Login'), findsOneWidget); // Adjusted to 4
    });
  });
}
