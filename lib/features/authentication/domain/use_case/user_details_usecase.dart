import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/features/authentication/data/models/auth_api_model.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDetailUseCaseProvider = Provider.autoDispose<UserDetailUseCase>(
    (ref) => UserDetailUseCase(authRepository: ref.read(iAuthRepositoryProvider)));


class UserDetailUseCase {
  final IAuthRepository authRepository;

  UserDetailUseCase({required this.authRepository});

  Future<Either<Failure, List<AuthApiModel>>> getUserDetails(int page) async {
    return await authRepository.getUserDetails(page);
  }
}
