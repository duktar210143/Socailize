import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepositoryImplProvider = Provider.autoDispose<IAuthRepository>(
    (ref) => AuthRemoteRepositoryImpl(ref.read(authRemoteDataSoureProvider)));

class AuthRemoteRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> signUpUser(AuthEntity user) async {
    // TODO: implement signUpUser
    return _authRemoteDataSource.signUpUser(user);
  }

  @override
  Future<Either<Failure, bool>> signInUser(String userName, String password) {
    // TODO: implement signInUser
    throw UnimplementedError();
  }
}
