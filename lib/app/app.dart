import 'package:discussion_forum/app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.signUpRoute,
      routes: AppRoutes.getAppliactionRoute(),
    );
  }
}
