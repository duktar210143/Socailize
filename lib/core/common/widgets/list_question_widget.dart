import 'package:discussion_forum/features/question/presentation/state/question_state.dart';
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
    Key? key,
    required this.questionProvider,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListQuestionWidgetState();
}

class _ListQuestionWidgetState extends ConsumerState<ListQuestionWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(widget.questionProvider);
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of Questions'),
        ),
        body: ListView.separated(
          itemCount: questionState.questions.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final reversedIndex = questionState.questions.length - index - 1;
            final question = questionState.questions[reversedIndex];
            return ListTile(
              title: Text(
                question.question,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.questionId ?? 'No id',
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (question.questionImageUrl != null)
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
                          question.questionImageUrl!,
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
                                      question.questionId!, context);
                              // move to reply view screen

                              // ignore: use_build_context_synchronously
                              _showReplyForm(
                                context,
                                question.questionId!,
                              );
                            },
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${question.replies?.length}",
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
    final reversedIndex = questionState.questions.length - index - 1;
    final question = questionState.questions[reversedIndex];

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
                      question.questionImageUrl!,
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
      builder: (BuildContext context) {
        return ReplyFormView(questionId: questionId);
      },
    );
  }
}
