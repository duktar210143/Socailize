import 'dart:io';

import 'package:discussion_forum/core/common/snackbar/my_snack_bar.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:discussion_forum/features/question/domain/use_case/delete_question_use_case.dart';
import 'package:discussion_forum/features/question/domain/use_case/get_all_questions_usecase.dart';
import 'package:discussion_forum/features/question/domain/use_case/question_use_case.dart';
import 'package:discussion_forum/features/question/presentation/state/question_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionViewModelProvider =
    StateNotifierProvider<QuestionViewModel, QuestionState>(
        (ref) => QuestionViewModel(
              addQuestionUseCase: ref.read(addQuestionUseCaseProvider),
              getAllQuestionsUseCase: ref.read(getAllQuestionsUseCaseProvider),
              deletequestionUsecase: ref.read(deleteQuestionUseCaseProvider),
            ));

class QuestionViewModel extends StateNotifier<QuestionState> {
  final AddQuestionUseCase addQuestionUseCase;
  final GetAllQuestionsUseCase getAllQuestionsUseCase;
  final DeletequestionUsecase deletequestionUsecase;

  QuestionViewModel({
    required this.addQuestionUseCase,
    required this.getAllQuestionsUseCase,
    required this.deletequestionUsecase,
  }) : super(QuestionState.initialState()) {
    getAllQuestions();
  }

  Future<void> addQuestions(QuestionEntity question, File? image) async {
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

  Future getAllQuestions() async {
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

  Future<void> deleteQuestion(
      BuildContext context, QuestionEntity question) async {
    state.copyWith(isLoading: true);
    print(question);
    var data = await deletequestionUsecase.deleteQuestion(question.questionId!);

    data.fold((failiure) {
      showSnackBar(
          message: failiure.error, context: context, color: Colors.red);
      state = state.copyWith(isLoading: false);
    }, (delete) {
      state.questions.remove(question);
      showSnackBar(message: "question Deleted SuccessFully", context: context);
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
