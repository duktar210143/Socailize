import 'package:discussion_forum/core/common/widgets/icons_button.dart';
import 'package:discussion_forum/features/messages/data/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key, required this.messageData});

  final Messagedata messageData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: const [IconsButton()],
        title: _AppBarTitle(messagedata: messageData),
      ),
      body: const Text("data"),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    Key? key,
    required this.messagedata,
  }) : super(key: key);

  final Messagedata messagedata;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(messagedata.profile),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messagedata.senderName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 2),
            const Text(
              "Online",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )
          ],
        ))
      ],
    );
  }
}

class _DemoStateless extends StatelessWidget {
  const _DemoStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [],
    );
  }
}

class _DateLabel extends StatelessWidget {
  const _DateLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12)),
        ),
      ),
    );
  }
}
