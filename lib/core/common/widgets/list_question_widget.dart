import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:discussion_forum/config/constants/size_constants.dart';
import 'package:discussion_forum/features/question/presentation/state/question_state.dart';
import 'package:discussion_forum/features/question/presentation/view_model/public_question_view_model.dart';
import 'package:discussion_forum/features/question/presentation/view_model/question_view_model.dart';
import 'package:discussion_forum/features/replies/presentation/view/reply_view.dart';
import 'package:discussion_forum/features/replies/presentation/view_model/reply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ListQuestionWidget extends ConsumerStatefulWidget {
  final StateNotifierProvider<dynamic, QuestionState> questionProvider;

  const ListQuestionWidget({
    Key? key,
    required this.questionProvider,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListQuestionWidgetState();
}

class _ListQuestionWidgetState extends ConsumerState<ListQuestionWidget> {
  late ShakeDetector shakeDetector;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeShakeDetector();
  }

  void _initializeShakeDetector() async {
    shakeDetector = ShakeDetector(
      onShake: () {
        ref
            .read(publicQuestionViewModelProvider.notifier)
            .getAllPublicUserQuestions();
      },
    );
    shakeDetector.startListening();
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(widget.questionProvider);
    return Expanded(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(publicQuestionViewModelProvider.notifier)
                .getAllPublicUserQuestions();
          },
          child: ListView.builder(
            itemCount: questionState.questions.length,
            itemBuilder: (context, index) {
              final reversedIndex = questionState.questions.length - index - 1;
              final question = questionState.questions[reversedIndex];
              return Card(
                color: Theme.of(context).colorScheme.secondary,
                elevation: 3,
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${question.user!.image}"),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                question.user!.firstname,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await ref
                                  .read(questionViewModelProvider.notifier)
                                  .deleteQuestion(context, question);

                              ref
                                  .read(questionViewModelProvider.notifier)
                                  .getAllQuestions();
                              ref
                                  .read(
                                      publicQuestionViewModelProvider.notifier)
                                  .getAllPublicUserQuestions();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        question.question,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
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
                            width: SizeConstants.photoViewWidth(context),
                            height: SizeConstants.photoViewHeight(context),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
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
                backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
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
        return SizedBox(
          height: SizeConstants.replyFormHeight(context), // Adjust as needed
          child: ReplyFormView(questionId: questionId),
        );
      },
    );
  }
}

class ShakeDetector {
  final Function onShake;
  StreamSubscription<AccelerometerEvent>? _subscription;

  ShakeDetector({required this.onShake});

  void startListening() {
    _subscription = accelerometerEvents?.listen((event) {
      final double acceleration = event.y;

      if (acceleration > 18) {
        onShake();
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
