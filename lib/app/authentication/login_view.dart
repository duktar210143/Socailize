import 'package:discussion_forum/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                textFormField(
                  hintText: "username",
                  controller: usernameController,
                  color: Colors.black,
                ), //custom text form field
                textFormField(
                  hintText: "password",
                  controller: passwordController,
                  color: Colors.black,
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
                    onPressed: () {},
                    child: const Text(
                      "login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
