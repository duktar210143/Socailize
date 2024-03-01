import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';

class QuestionState {
  final bool isLoading;
  final List<QuestionEntity> questions;
  final bool showMessage;
  final AuthEntity? user;
  final String error;

  QuestionState(
      {required this.isLoading,
      required this.questions,
      required this.showMessage,
      this.user,
      required this.error
      });

  factory QuestionState.initialState() => QuestionState(
      isLoading: false, questions: [], showMessage: false, user: null, error: '');

  QuestionState copyWith(
      {bool? isLoading,
      List<QuestionEntity>? questions,
      bool? showMessage,
      AuthEntity? user,
      String? error}) {
    return QuestionState(
        isLoading: isLoading ?? this.isLoading,
        questions: questions ?? this.questions,
        user: user ?? this.user,
        showMessage: showMessage ?? this.showMessage,
        error: error ?? this.error
        );
  }
}
