import 'package:discussion_forum/features/question/domain/use_case/get_all_public_question_usecase.dart';
import 'package:discussion_forum/features/question/presentation/state/question_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final publicQuestionViewModelProvider =
    StateNotifierProvider.autoDispose<PublicQuestionViewModel, QuestionState>(
  (ref) => PublicQuestionViewModel(
      getAllPublicQuestionUseCase:
          ref.read(getAllPublicQuestionUseCaseProvider)),
);

class PublicQuestionViewModel extends StateNotifier<QuestionState> {
  final GetAllPublicQuestionUseCase getAllPublicQuestionUseCase;

  PublicQuestionViewModel({
    required this.getAllPublicQuestionUseCase,
  }) : super(QuestionState.initialState()) {
    getAllPublicUserQuestions();
  }


// get all public user questions go here

  Future getAllPublicUserQuestions() async{
    state = state.copyWith(isLoading: true);
    getAllPublicQuestionUseCase.getAllPublicUserQuestions().then((value) {
      value.fold((failure) {
        state = state.copyWith(isLoading: false);
        // Print or log the error for debugging
        print('Failed to fetch question: $failure');
      }, (questions) {
        if (questions != null) {
          state = state.copyWith(isLoading: false, questions: questions);
        } else {
          state = state.copyWith(isLoading: false);
          // Print or log a message for debugging
          print('Received null questions');
        }
      });
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
