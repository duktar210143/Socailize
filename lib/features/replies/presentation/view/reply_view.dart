import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:discussion_forum/core/common/widgets/view_user_details.dart';
import 'package:discussion_forum/core/network/remote/socket_service.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:discussion_forum/features/replies/presentation/state/reply_state.dart';
import 'package:discussion_forum/features/replies/presentation/view_model/reply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ReplyFormView extends ConsumerStatefulWidget {
  final String questionId;

  const ReplyFormView({Key? key, required this.questionId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewFormViewState();
}

class _ReviewFormViewState extends ConsumerState<ReplyFormView> {
  late TextEditingController _replyController;
  late Socket socket;

  @override
  void initState() {
    super.initState();
    _replyController = TextEditingController();
    socket = ref.read(socketServiceProvider).socket;
    // Remove any existing event listeners
    socket.off("new reply");
    // Add the event listener
    socket.on("new reply", (reply) {
      print("Callback triggered with reply: $reply");
      _showNotification(reply);
    });
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  Widget _buildUserInfo(ReplyState replyState) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "${replyState.user!.image}",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17),
                child: Text(
                  replyState.user!.firstname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReplyList(ReplyState replyState) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: replyState.replies.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final reversedIndex = replyState.replies.length - index - 1;
        final replies = replyState.replies[reversedIndex];
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: InkWell(
              onTap: () {
                // show user details the details concerns are seperated into another file
                UserDetailsDialogBox.showUserNameDialog(
                    context,
                    replies.user!.firstname,
                    replies.user!.lastname,
                    replies.user!.username,
                    replies.user!.image.toString(),
                    replies.user!.email);
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue, // Adjust the color as needed
                backgroundImage: NetworkImage("${replies.user!.image}"),
              ),
            ),
            title: Text(
              replies.reply,
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                :Colors.black, // Adjust text color
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final replyState = ref.watch(replyViewModelProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // _buildUserInfo(replyState),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _replyController,
                maxLines: 6,
                decoration: const InputDecoration(
                  hintText: 'Add a Reply...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String questionId = widget.questionId;
                ReplyEntity entity = ReplyEntity(reply: _replyController.text);
                await ref
                    .read(replyViewModelProvider.notifier)
                    .setReply(questionId, entity, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.4, // Adjust as needed
              child: _buildReplyList(replyState),
            ),
          ],
        ),
      ),
    );
  }
// function to create notification
void _showNotification(dynamic reply) {
  final String firstname = reply["users"][0]["firstname"]; // Assuming you want the first user in the array
  final String userimage = reply["users"][0]["image"];
  // final String replyText = reply["reply"]['question'];
  final String questionImg = reply["reply"]["questionImageUrl"];
  final String questionRepliedTo = reply["reply"]["question"];

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      title: 'New Reply',
      body: '$firstname replied to: $questionRepliedTo',
      bigPicture: questionImg,
      largeIcon: userimage,
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );

}

}
