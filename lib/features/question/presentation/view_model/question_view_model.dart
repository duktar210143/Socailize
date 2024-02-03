import 'dart:io';

import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/use_case/get_all_public_question_usecase.dart';
import 'package:discussion_forum/features/question/domain/use_case/get_all_questions_usecase.dart';
import 'package:discussion_forum/features/question/domain/use_case/question_use_case.dart';
import 'package:discussion_forum/features/question/presentation/state/question_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionViewModelProvider =
    StateNotifierProvider.autoDispose<QuestionViewModel, QuestionState>(
  (ref) => QuestionViewModel(
      addQuestionUseCase: ref.read(addQuestionUseCaseProvider),
      getAllQuestionsUseCase: ref.read(getAllQuestionsUseCaseProvider),
  )
);

class QuestionViewModel extends StateNotifier<QuestionState> {
  final AddQuestionUseCase addQuestionUseCase;
  final GetAllQuestionsUseCase getAllQuestionsUseCase;

  QuestionViewModel({
    required this.addQuestionUseCase,
    required this.getAllQuestionsUseCase,
  }) : super(QuestionState.initialState()) {
    getAllQuestions();
  }

  void addQuestions(QuestionEntity question, File? image) {
    state = state.copyWith(isLoading: true);
    addQuestionUseCase.addQuestion(question, image).then((value) {
      value.fold(
        (failure) => state = state.copyWith(isLoading: false),
        (success) {
          state = state.copyWith(isLoading: false, showMessage: true);
          getAllQuestions();
        },
      );
    });
  }

//  get all user specific questions code here

  void getAllQuestions() {
    state = state.copyWith(isLoading: true);
    getAllQuestionsUseCase.getAllQuestions().then((value) {
      value.fold(
        (failure) {
          state = state.copyWith(isLoading: false);
          // Print or log the error for debugging
          print('Failed to fetch questions: $failure');
        },
        (questions) {
          if (questions != null) {
            state = state.copyWith(isLoading: false, questions: questions);
          } else {
            state = state.copyWith(isLoading: false);
            // Print or log a message for debugging
            print('Received null questions');
          }
        },
      );
    });
  }


  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
