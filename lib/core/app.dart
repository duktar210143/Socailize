import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/common/Theme/dark_theme.dart';
import 'package:discussion_forum/core/common/Theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Discussion Forum App',
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoute(),

    );
  }
}
