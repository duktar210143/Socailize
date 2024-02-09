import 'package:discussion_forum/core/common/widgets/view_user_details.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:discussion_forum/features/replies/presentation/state/reply_state.dart';
import 'package:discussion_forum/features/replies/presentation/view_model/reply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReplyFormView extends ConsumerStatefulWidget {
  final String questionId;

  const ReplyFormView({Key? key, required this.questionId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReviewFormViewState();
}

class _ReviewFormViewState extends ConsumerState<ReplyFormView> {
  late TextEditingController _replyController;

  @override
  void initState() {
    super.initState();
    _replyController = TextEditingController();
  }

  Widget _buildUserInfo(ReplyState replyState) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
              Text(
                replyState.user!.firstname,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                replyState.user!.email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: replyState.replies.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final reversedIndex = replyState.replies.length - index - 1;
        final replies = replyState.replies[reversedIndex];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
          ),
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
                   replies.user!.email);
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue, // Adjust the color as needed
                child: Text(
                  replies.user!
                      .firstname[0], // Display first letter of firstname
                  style: const TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(
              replies.reply,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black, // Adjust text color
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
      appBar: AppBar(
        title: const Text('Reply Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfo(replyState),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              color: Colors.white70,
              height: 23,
              child: Center(
                child: Text("Total Replies: ${replyState.replies.length}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 17)),
              ),
            ),
            TextField(
              controller: _replyController,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: 'Add a Reply...',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String questionId = widget.questionId;
                ReplyEntity entity = ReplyEntity(reply: _replyController.text);
                ref
                    .read(replyViewModelProvider.notifier)
                    .setReply(questionId, entity, context);

                // Navigator.pop(context);
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
            _buildReplyList(replyState),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }
}
