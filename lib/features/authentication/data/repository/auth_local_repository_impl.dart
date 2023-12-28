import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/data/data_source/auth_local_data_source.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryImplProvider = Provider.autoDispose<IAuthRepository>(
  (ref) => AuthLocalRepositoryImpl(ref.read(authLocalDataSourceProvider)));

class AuthLocalRepositoryImpl implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepositoryImpl(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> signUpUser(UserEntity user) async {
    // TODO: implement signUpUser
    return _authLocalDataSource.signUpUser(user);
  }
}
