import 'package:dartz/dartz.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/network/local/hive_service.dart';
import 'package:discussion_forum/features/authentication/data/models/user_hive_model.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider.autoDispose<AuthLocalDataSource>(
    (ref) => AuthLocalDataSource(ref.read(hiveSerivceProvider)));

class AuthLocalDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  Future<Either<Failure, bool>> signUpUser(AuthEntity user) async {
    try {
      // Convert user Entity to hive model
      UserHiveModel userHiveModel = UserHiveModel.toHiveModel(user);

      // Wait for addUser to complete
      bool success = await _hiveService.addUser(userHiveModel);

      // Check the result and return accordingly
      if (success) {
        // Print the contents of the Hive box
        await HiveService().printUserBoxContents();
        return const Right(true);
      }

      // Return an error if the registration failed
      return left(Failure(error: 'User registration failed'));
    } catch (e) {
      // Return an error if an exception occurs
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> signInUser(
      String userName, String password) async {
    try {
      UserHiveModel? user = await _hiveService.signInUser(userName, password);
      if (user == null) {
        return left(Failure(error: 'Username or password does not match'));
      } else {
        return const Right(true);
      }
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
