import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) => LoginUseCase(
    authRepository: ref.read(iAuthRepositoryProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider)));

class LoginUseCase {
  final IAuthRepository authRepository;
  final UserSharedPrefs userSharedPrefs;

  LoginUseCase({required this.userSharedPrefs, required this.authRepository});

  Future<Either<Failure, AuthEntity>> login(
      String userName, String password) async {
    try {
      final authResult = await authRepository.login(userName, password);

      // Check if the login was successful
      return authResult.fold(
        (failure) => Left(failure), // Return the failure if login failed
        (userData) async {
          // Store user data in SharedPreferences
          final userStorageResult = await userSharedPrefs.setUserData(userData);

          // Check if storing user data was successful
          return userStorageResult.fold(
            (failure) => Left(failure), // Return the failure if storing data failed
            (_) => Right(userData), // Return user data if everything was successful
          );
        },
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}

