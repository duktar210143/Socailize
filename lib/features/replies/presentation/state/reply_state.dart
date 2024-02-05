// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';

class ReplyState {
  final bool isLoading;
  final List<ReplyEntity> replies;
  final bool showMessage;
  final AuthEntity? user;

  ReplyState({
    required this.isLoading,
    required this.replies,
    required this.showMessage,
    this.user
  });

  factory ReplyState.initialState() =>
      ReplyState(isLoading: false, replies: [], showMessage: false, user: null);

  ReplyState copyWith({
    bool? isLoading,
    List<ReplyEntity>? replies,
    bool? showMessage,
    AuthEntity? user
  }) {
    return ReplyState(
      isLoading: isLoading ?? this.isLoading,
      replies: replies ?? this.replies,
      showMessage: showMessage ?? this.showMessage,
      user: user ?? this.user
    );
  }

  @override
  String toString() =>
      'ReplyState(isLoading: $isLoading, replies: $replies, showMessage: $showMessage),user:$user';
}
