import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';

class QuestionState {
  final bool isLoading;
  final List<QuestionEntity> questions;
  final bool showMessage;
  final AuthEntity? user;

  QuestionState(
      {required this.isLoading,
      required this.questions,
      required this.showMessage,
      this.user});

  factory QuestionState.initialState() => QuestionState(
      isLoading: false, questions: [], showMessage: false, user: null);

  QuestionState copyWith(
      {bool? isLoading,
      List<QuestionEntity>? questions,
      bool? showMessage,
      AuthEntity? user}) {
    return QuestionState(
        isLoading: isLoading ?? this.isLoading,
        questions: questions ?? this.questions,
        user: user ?? this.user,
        showMessage: showMessage ?? this.showMessage);
  }
}
