import 'package:flutter/material.dart';
import 'package:discussion_forum/config/router/app_routes.dart';
import 'package:discussion_forum/features/messages/data/model/message_model.dart';
import 'package:discussion_forum/features/messages/presentation/chat_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoute.chatsScreenRoute) {
      final messageData = settings.arguments as Messagedata;
      return MaterialPageRoute(
        builder: (context) {
          return ChatScreen(messageData: messageData);
        },
      );
    }
    // Add more route handling if needed
    return null;
  }

  static Map<String, WidgetBuilder> get routes => AppRoute.getApplicationRoute();
}
