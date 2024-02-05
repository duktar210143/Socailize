import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/replies/data/repository/reply_remote_repo_impl.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final iReplyrepoProvider = Provider.autoDispose<IReplyRepo>((ref) {
  return ref.read(replyRemoteRepoImplProvider);
});

abstract class IReplyRepo {
  // setReply repo
  Future<Either<Failure, bool>> addReply(String questionId, ReplyEntity entity);

  //getQuestionspecific replies repo
  Future<Either<Failure, List<ReplyEntity>>> getUserSpecificReplies(
      String questionId);
}
