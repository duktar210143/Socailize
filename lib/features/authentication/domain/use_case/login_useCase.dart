import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginUseCaseProvider = Provider<LoginUseCase>(
    (ref) => LoginUseCase(authRepository: ref.read(iAuthRepositoryProvider)));

class LoginUseCase {
  final IAuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, bool>> login(
      String userName, String password) async {
    return await authRepository.login(userName, password);
  }
}
