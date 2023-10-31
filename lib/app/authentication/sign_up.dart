import 'package:discussion_forum/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion Forum"),
      ),
      body: Stack(
        children: <Widget>[
          const RiveAnimation.asset(
            'assets/images/viking-strike.riv',
            fit: BoxFit.cover, // Ensure the animation covers the entire space
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                textFormField(
                  hintText: "Create user",
                  controller: emailController,
                ),
                textFormField(
                  hintText: "Create password",
                  controller: passwordController,
                ),
                textFormField(
                  hintText: "Confirm password",
                  controller: confirmPasswordController,
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                  height: 100,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
