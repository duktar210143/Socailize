import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/data/models/user_hive_model.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider<AuthUseCase>(
    (ref) => AuthUseCase(authRepository: ref.read(iAuthRepositoryProvider)));

class AuthUseCase {
  final IAuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<Either<Failure, bool>> signUpUser(AuthEntity user) async {
    return await authRepository.signUpUser(user);
  }

  Future<Either<Failure, bool>> signInUser(
      String userName, String password) async {
    return await authRepository.signInUser(userName, password);
  }
}
