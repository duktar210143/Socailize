import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/data/repository/auth_local_repository_impl.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final iAuthRepositoryProvider = Provider.autoDispose<IAuthRepository>
((ref) {
// if there isn't an internet connection include operations in local data source
  return ref.read(authLocalRepositoryImplProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> signUpUser(UserEntity user);
}
