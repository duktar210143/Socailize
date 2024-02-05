import 'package:discussion_forum/core/common/widgets/list_question_widget.dart';
import 'package:discussion_forum/features/question/presentation/view_model/public_question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PublicQuestionView extends ConsumerStatefulWidget {
  const PublicQuestionView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PublicQuestionViewState();
}

class _PublicQuestionViewState extends ConsumerState<PublicQuestionView> {
  @override
  Widget build(BuildContext context) {
    return  ListQuestionWidget(questionProvider: publicQuestionViewModelProvider,);
  }
}
