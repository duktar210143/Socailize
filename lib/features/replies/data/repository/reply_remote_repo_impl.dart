import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/replies/data/data_source/replies_remote_data_source.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:discussion_forum/features/replies/domain/repository/reply_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final replyRemoteRepoImplProvider = Provider<ReplyRemoteRepoImpl>((ref) {
  return ReplyRemoteRepoImpl(
      replyRemoteDataSource: ref.read(replyRemoteDataSourceProvider));
});

class ReplyRemoteRepoImpl implements IReplyRepo {
  final ReplyRemoteDataSource replyRemoteDataSource;

  ReplyRemoteRepoImpl({required this.replyRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addReply(
      String questionId, ReplyEntity entity) {
    // TODO: implement addReply
    return replyRemoteDataSource.addReply(questionId, entity);
  }

  @override
  Future<Either<Failure, List<ReplyEntity>>> getUserSpecificReplies(
      String questionId) {
    // TODO: implement getUserSpecificReplies
    return replyRemoteDataSource.getUserSpecificReplies(questionId);
  }
}
