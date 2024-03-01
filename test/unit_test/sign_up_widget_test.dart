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

      expect(find.text('SignUp'), findsOneWidget);
    });

testWidgets('Renders all text form fields', (tester) async {
  await tester.pumpWidget(
    const ProviderScope(child: MaterialApp(home: SignUpView())),
  );
  await tester.pumpAndSettle(const Duration(seconds: 5)); // Increase timeout duration

  expect(find.byType(CustomTextFormField), findsNWidgets(6)); // Adjusted to 4
});


    testWidgets('Renders "Already have an account" text', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: MaterialApp(home: SignUpView())),
      );
      await tester.pumpAndSettle();

      expect(find.text("Already have an account ??"), findsOneWidget);
    });

  });
}
