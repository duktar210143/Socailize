import 'package:discussion_forum/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../providers/user_provider.dart';
import '../routes/app_routes.dart';

class SignUpView extends ConsumerWidget {
  SignUpView({
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> _authKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RegExp emailValid = RegExp(
      r"^[^_.]([a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]+[^_]){2}@{1}[a-z0-9]+[.]{1}(([a-z]{2,3})|([a-z]{2,3}[.]{1}[a-z]{2,3}))$");

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion Forum"),
      ),
      body: Stack(
        children: <Widget>[
          const RiveAnimation.asset(
            'assets/images/zombie.riv',
            fit: BoxFit.cover, // Ensure the animation covers the entire space
          ),
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _authKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      hintText: "Create user",
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        } else if (!emailValid.hasMatch(value)) {
                          return "please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Create password",
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Confirm password",
                      controller: confirmPasswordController,
                      validator: (value) {
                        final password = passwordController.text;
                        if (value == null || value.isEmpty) {
                          return "Please re-enter your password";
                        } else if (value != password) {
                          return "password and confirm password doesn't match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20)),
                      height: 100,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (_authKey.currentState!.validate()) {
                            try {
                              // _auth.createUserWithEmailAndPassword(
                              //     email: emailController.text,
                              //     password: passwordController.text);
                              // after validating SignUp the user with stateNotifierProvider
                              ref.watch(userStateProvider.notifier).signUp(
                                  emailController.text ?? '',
                                  passwordController.text ?? '');
                              Navigator.pushNamed(
                                context,
                                AppRoutes.homeRoute,
                              ); //when clicked navigate to login page
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.toString(),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ??",
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.loginRoute,
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
