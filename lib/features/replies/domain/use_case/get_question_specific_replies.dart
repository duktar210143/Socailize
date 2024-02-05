import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:discussion_forum/features/replies/domain/repository/reply_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getQuestionSpecificRepliesUseCaseProvider = Provider.autoDispose<GetQuestionSpecificRepliesUseCase>(
  (ref) {
  return GetQuestionSpecificRepliesUseCase(repository: ref.read(iReplyrepoProvider));
});

class GetQuestionSpecificRepliesUseCase {
  final IReplyRepo repository;

  GetQuestionSpecificRepliesUseCase({required this.repository});

  //getQuestionspecific replies usecase
  Future<Either<Failure, List<ReplyEntity>>> getUserSpecificReplies(
      String questionId) {
    return repository.getUserSpecificReplies(questionId);
  }
}
