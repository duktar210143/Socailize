import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:discussion_forum/features/replies/domain/repository/reply_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setReplyUseCaseProvider = Provider<SetReplyUseCase>((ref) {
  return SetReplyUseCase(
      repository: ref.read(iReplyrepoProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider));
});

class SetReplyUseCase {
  final IReplyRepo repository;
  final UserSharedPrefs userSharedPrefs;

  SetReplyUseCase({required this.repository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> addreply(
      String questionId, ReplyEntity entity) async {
    return await repository.addReply(questionId, entity);
  }

  Future<Either<bool, AuthEntity>> getUserData() async {
    Either<Failure, AuthEntity?> userData = await userSharedPrefs.getUserData();
    return userData.fold(
      (failure) {
        print('Error retrieving user data: ${failure.error}');
        return const Left(false);
      },
      (authEntity) {
        if (authEntity != null) {
          return Right(
              authEntity); // Returning a Right with the AuthEntity if it exists
        } else {
          return const Left(
              false); // Returning a Left with a boolean value indicating failure (e.g., user data is null)
        }
      },
    );
  }
}
