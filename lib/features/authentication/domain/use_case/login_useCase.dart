// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:discussion_forum/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) => LoginUseCase(
    authRepository: ref.read(iAuthRepositoryProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider)));

class LoginUseCase {
  final IAuthRepository authRepository;
  final UserSharedPrefs userSharedPrefs;

  LoginUseCase({required this.userSharedPrefs, required this.authRepository});

  Future<Either<Failure, AuthData>> login(
      String userName, String password) async {
    try {
      final authResult = await authRepository.login(userName, password);

      // Check if the login was successful
      return authResult.fold(
        (failure) => Left(failure), // Return the failure if login failed
        (authData) async {
          // store user Token in the sharedPreference
          await userSharedPrefs.setUserToken(authData.token);

          // Store user data in SharedPreferences
          final userStorageResult =
              await userSharedPrefs.setUserData(authData.userData);

          // Check if storing user data was successful
          return userStorageResult.fold(
            (failure) =>
                Left(failure), // Return the failure if storing data failed
            (_) {
              return Right(authData);
            }, // Return user data if everything was successful
          );
        },
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<bool> logout() async {
    try {
      await userSharedPrefs.deleteUserToken();
      await userSharedPrefs.deleteUserData();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Either<Failure, bool>> forgotPassword(String email) async{
    return await authRepository.forgotPassword(email);
  }
}
