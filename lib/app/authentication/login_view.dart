import 'package:discussion_forum/app/routes/app_routes.dart';
import 'package:discussion_forum/providers/user_provider.dart';
import 'package:discussion_forum/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GlobalKey<FormState> authKey = GlobalKey();
    final RegExp emailValid = RegExp(
        r"^[^_.]([a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]+[^_]){2}@{1}[a-z0-9]+[.]{1}(([a-z]{2,3})|([a-z]{2,3}[.]{1}[a-z]{2,3}))$");

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion Forum"),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            const RiveAnimation.asset(
              'assets/images/polar-bear.riv',
              fit: BoxFit.cover, // Ensure the animation covers the entire space
            ),
            Form(
              key: authKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextFormField(
                    hintText: "username",
                    controller: usernameController,
                    color: Colors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!emailValid.hasMatch(value)) {
                        return "please enter a valid email";
                      }
                      return null;
                    },
                  ), //custom text form field
                  CustomTextFormField(
                    hintText: "password",
                    controller: passwordController,
                    color: Colors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 100,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        if (authKey.currentState!.validate()) {
                          try {
                            // await auth.signInWithEmailAndPassword(
                            //   email: usernameController.text,
                            //   password: passwordController.text,
                            // );
                            // send an api request to check whether the user credentials exists
                            final success = await ref
                                .watch(userStateProvider.notifier)
                                .login(usernameController.text,
                                    passwordController.text);

                            if (success) {
                              Navigator.pushNamed(context, AppRoutes.homeRoute);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('user with that username of password donot exist'),
                                ),
                              );
                              Navigator.pushNamed(context, AppRoutes.loginRoute);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "login",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ??",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.signUpRoute,
                          );
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
