// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:discussion_forum/core/network/remote/socket_service.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class NotifyView extends ConsumerStatefulWidget {
//   const NotifyView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _NotifyViewState();
// }

// class _NotifyViewState extends ConsumerState<NotifyView> {
//   late SocketService socketService;

//   @override
//   void initState() {
//     socketService = ref.read(socketServiceProvider);
//     socketService.connect();
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//      // Listen for "new reply" event
//     socketService.socket.on("new reply", (reply) {
//       // Handle the new reply event
//       print("New reply received: $reply");
//       // Show a notification
//       _showNotification();
//     });
//     super.initState();
//   }

//     void _showNotification() {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 10,
//         channelKey: 'basic_channel',
//         title: 'New Reply',
//         body: 'A new reply has been posted.',
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [],
//     );
//   }
// }
