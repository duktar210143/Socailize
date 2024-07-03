import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/core/common/Theme/dark_theme.dart';
import 'package:discussion_forum/core/common/Theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class App extends ConsumerWidget {
  const App({super.key, required  this.client});
  final StreamChatClient client;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Discussion Forum App',
      builder: (context, child) {
        return StreamChatCore(
          client: client,
          child: child!,
        );
      },
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
