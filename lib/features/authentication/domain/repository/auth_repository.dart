import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:discussion_forum/features/authentication/data/repository/auth_Remote_repository_impl.dart';
// import 'package:discussion_forum/features/authentication/data/repository/auth_local_repository_impl.dart';
// import 'package:discussion_forum/features/authentication/data/repository/auth_local_repository_impl.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final iAuthRepositoryProvider = Provider.autoDispose<IAuthRepository>((ref) {
// if there isn't an internet connection include operations in local data source
  return ref.read(authRemoteRepositoryImplProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> signUpUser(AuthEntity user);

  Future<Either<Failure, AuthData>> login(String username, String password);

  Future<Either<Failure, AuthEntity>> uploadProfile(File image);
}
