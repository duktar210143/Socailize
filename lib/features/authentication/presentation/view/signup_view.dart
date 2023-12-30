import 'package:discussion_forum/core/common/snackbar/my_snack_bar.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:discussion_forum/core/common/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final GlobalKey<FormState> _authKey = GlobalKey();
  final _fnameController = TextEditingController(text: "Duktar");
  final _lnameController = TextEditingController(text: 'Tamang');
  final _userNameController = TextEditingController(text: 'Duktar13');
  final _emailController = TextEditingController(text: 'Duktar@gmail.com');
  final _passwordController = TextEditingController(text: 'test123');
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RegExp emailValid = RegExp(
      r"^[^_.]([a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]+[^_]){2}@{1}[a-z0-9]+[.]{1}(([a-z]{2,3})|([a-z]{2,3}[.]{1}[a-z]{2,3}))$");

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
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
                    CustomTextFormField(
                      hintText: "First Name",
                      controller: _fnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Last Name",
                      controller: _lnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Create user",
                      controller: _emailController,
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
                      hintText: "UserName",
                      controller: _userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      hintText: "Create password",
                      controller: _passwordController,
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
                        final password = _passwordController.text;
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
                        onPressed: () async {
                          if (_authKey.currentState!.validate()) {
                            UserEntity user = UserEntity(
                              firstName: _fnameController.text,
                              lastName: _lnameController.text,
                              email: _emailController.text,
                              userName: _userNameController.text,
                              password: _passwordController.text,
                            );

                            try {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .signUpUser(user);

                              // If signUpUser does not throw an exception, show success message
                              // ignore: use_build_context_synchronously
                              if (authState.error != null) {
                                // ignore: use_build_context_synchronously
                                showSnackBar(
                                  message: 'Registered successfully',
                                  context: context,
                                  color: Colors.green,
                                );
                              }else{
                                // ignore: use_build_context_synchronously
                                showSnackBar(
                                message: 'user with that username already exists',
                                context: context,
                                color: Colors.red,
                              );
                              }
                            } catch (error) {
                              // If signUpUser throws an exception, show error message
                              print(error);
                              // ignore: use_build_context_synchronously
                              showSnackBar(
                                message: error.toString(),
                                context: context,
                                color: Colors.red,
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
                            // Navigator.pushNamed(
                            //   // context,
                            //   // AppR.loginRoute,
                            // );
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
