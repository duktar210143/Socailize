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

  Future<Either<Failure, bool>> signUpUser(UserEntity user) async {
    // TODO: implement signUpUser
    try {
      // convert user Entity to hive model
      UserHiveModel userHiveModel = UserHiveModel.toHiveModel(user);
      _hiveService.addUser(userHiveModel);
      return const Right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
