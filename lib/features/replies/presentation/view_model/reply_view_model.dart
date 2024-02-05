import 'package:discussion_forum/core/common/snackbar/my_snack_bar.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:discussion_forum/features/replies/domain/use_case/get_question_specific_replies.dart';
import 'package:discussion_forum/features/replies/domain/use_case/set_reply_use_case.dart';
import 'package:discussion_forum/features/replies/presentation/state/reply_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final replyViewModelProvider =
    StateNotifierProvider.autoDispose<ReplyViewModel, ReplyState>((ref) {
  return ReplyViewModel(
      setReplyUseCase: ref.read(setReplyUseCaseProvider),
      getQuestionSpecificRepliesUseCase:
          ref.read(getQuestionSpecificRepliesUseCaseProvider));
});

class ReplyViewModel extends StateNotifier<ReplyState> {
  final SetReplyUseCase setReplyUseCase;
  final GetQuestionSpecificRepliesUseCase getQuestionSpecificRepliesUseCase;
  ReplyViewModel({
    required this.setReplyUseCase,
    required this.getQuestionSpecificRepliesUseCase,
  }) : super(ReplyState.initialState()) {
    getUserData();
  }

  void setReply(String questionId, ReplyEntity entity, BuildContext context) {
    state = state.copyWith(isLoading: true);
    setReplyUseCase.addreply(questionId, entity).then((value) {
      value.fold((failure) {
        return state = state.copyWith(isLoading: false);
      }, (success) {
        showSnackBar(message: "Replies saved successfully", context: context);
        return state = state.copyWith(isLoading: false, showMessage: true);
      });
    });
  }

  void getUserData() {
    state = state.copyWith(isLoading: true);
    setReplyUseCase.getUserData().then((value) {
      value.fold((failure) {
        return state = state.copyWith(isLoading: false);
      }, (authEntity) {
        return state = state.copyWith(isLoading: false, user: authEntity);
      });
    });
  }

  Future getQuestionSpecificReplies(String questionId, BuildContext context) {
    state = state.copyWith(isLoading: true);
     return getQuestionSpecificRepliesUseCase
        .getUserSpecificReplies(questionId)
        .then((value) {
      value.fold((failure) {
        return state = state.copyWith(isLoading: false);
      }, (replies) {
        return state = state.copyWith(isLoading: false, replies: replies);
      });
    });
  }
}
