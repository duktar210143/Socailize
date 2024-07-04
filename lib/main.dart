import 'package:discussion_forum/core/common/widgets/appwrite_app.dart';
import 'package:discussion_forum/core/app.dart';
import 'package:discussion_forum/core/network/local/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() async {
  // create a streamchat api client
  final client = StreamChatClient(streamKey);
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  runApp(
     ProviderScope(
      child: App(
        client: client,
      ),
    ),
  );
}
