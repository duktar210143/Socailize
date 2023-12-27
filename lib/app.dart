import 'package:discussion_forum/features/authentication/presentation/view/login_view.dart';
import 'package:discussion_forum/features/home/dashboard_view.dart';
import 'package:discussion_forum/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.homeRoute, // Set the initial route
      routes: AppRoutes.getAppliactionRoute(),
      onGenerateInitialRoutes: (String initialRoute) {
        return [
          MaterialPageRoute(
            builder: (context) {
              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("DashBoard"); // Navigate to the home screen if the user is logged in.
                  } else {
                    return const LoginView(); // Navigate to the sign-up screen if the user is not logged in.
                  }
                },
              );
            },
          ),
        ];
      },
    );
  }
}
