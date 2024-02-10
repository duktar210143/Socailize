import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider<AuthUseCase>(
    (ref) => AuthUseCase(authRepository: ref.read(iAuthRepositoryProvider),
     userSharedPrefs: ref.read(userSharedPrefsProvider)));

class AuthUseCase {
  final IAuthRepository authRepository;
  final UserSharedPrefs userSharedPrefs;

  AuthUseCase({required this.authRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> signUpUser(AuthEntity user) async {
    return await authRepository.signUpUser(user);
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
