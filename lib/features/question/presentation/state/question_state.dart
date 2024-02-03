
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';

class QuestionState {
  final bool isLoading;
  final List<QuestionEntity> questions;
  final bool showMessage;

  QuestionState({
    required this.isLoading,
    required this.questions,
    required this.showMessage,
  });

  factory QuestionState.initialState() =>
      QuestionState(isLoading: false, questions: [], showMessage: false);

  QuestionState copyWith({
    bool? isLoading,
    List<QuestionEntity>? questions,
    bool? showMessage,
  }) {
    return QuestionState(
        isLoading: isLoading ?? this.isLoading,
        questions: questions ?? this.questions,
        showMessage: showMessage ?? this.showMessage);
  }
}
