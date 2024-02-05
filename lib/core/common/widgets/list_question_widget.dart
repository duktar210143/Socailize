import 'package:discussion_forum/features/question/presentation/state/question_state.dart';
import 'package:discussion_forum/features/question/presentation/view_model/question_view_model.dart';
import 'package:discussion_forum/features/replies/presentation/view/reply_view.dart';
import 'package:discussion_forum/features/replies/presentation/view_model/reply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ListQuestionWidget extends ConsumerStatefulWidget {
  final AutoDisposeStateNotifierProvider<dynamic, QuestionState>
      questionProvider;

  const ListQuestionWidget({
    super.key,
    required this.questionProvider,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListQuestionWidgetState();
}

class _ListQuestionWidgetState extends ConsumerState<ListQuestionWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(widget.questionProvider);
    final replyState = ref.watch(replyViewModelProvider);
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of Questions'),
        ),
        body: ListView.separated(
          itemCount: questionState.questions.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                questionState.questions[index].question,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questionState.questions[index].questionId ?? 'No id',
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (questionState.questions[index].questionImageUrl != null)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                _buildZoomedImage(questionState, index),
                          ),
                        ).then((value) {
                          // Perform actions after returning from zoomed image
                          // For example, refresh the UI or execute other logic
                          // You can add more logic as needed
                        });
                      },
                      child: Hero(
                        tag: 'photoViewHero_$index',
                        child: Image.network(
                          questionState.questions[index].questionImageUrl!,
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_outline),
                            onPressed: () {
                              // Handle like button tap
                            },
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '123 Likes', // Replace with actual like count
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.comment),
                            onPressed: () async {
                              // get the question specific reply from the view model of reply
                              await ref
                                  .read(replyViewModelProvider.notifier)
                                  .getQuestionSpecificReplies(
                                      questionState
                                          .questions[index].questionId!,
                                      context);
                              // move to reply view screen

                              // ignore: use_build_context_synchronously
                              _showReplyForm(
                                context,
                                questionState.questions[index].questionId!,
                              );
                            },
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${ref.read(numberOfRepliesProvider(questionState.questions[index].questionId!))}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildZoomedImage(QuestionState questionState, int index) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: PhotoViewGallery.builder(
                itemCount: 1,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      questionState.questions[index].questionImageUrl!,
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                pageController: PageController(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReplyForm(BuildContext context, String questionId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ReplyFormView(questionId: questionId);
      },
    );
  }
}
