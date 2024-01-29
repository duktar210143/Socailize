import 'dart:io';

import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/use_case/question_use_case.dart';
import 'package:discussion_forum/features/question/presentation/state/question_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionViewModelProvider =
    StateNotifierProvider.autoDispose<QuestionViewModel, QuestionState>(
  (ref) =>
      QuestionViewModel(addQuestionUseCase: ref.read(addQuestionUseCaseProvider)),
);

class QuestionViewModel extends StateNotifier<QuestionState> {
  final AddQuestionUseCase addQuestionUseCase;

  QuestionViewModel({
    required this.addQuestionUseCase,
  }) : super(QuestionState.initialState()){
    // call function get all questions
  }

  void addQuestions(QuestionEntity question, File? image) {
    state = state.copyWith(isLoading: true);
    addQuestionUseCase.addQuestion(question,image).then((value) {
      value.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (success) {
          state = state.copyWith(isLoading: false, showMessage: true);
          // call get all question again here
        },
      );
    });
  }

//  get all question code here

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
