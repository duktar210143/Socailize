import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:discussion_forum/config/constants/api_end_points.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/network/remote/http_service.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/authentication/data/models/auth_api_model.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider.autoDispose<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider)),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, bool>> signUpUser(AuthEntity entity) async {
    print(AuthApiModel.fromEntity(entity).toJson());
    try {
      AuthApiModel authApiModel = AuthApiModel.fromEntity(entity);

      var response = await dio.post(
        ApiEndPoints.signUp,
        data: authApiModel.toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'] ?? 'Unknown error',
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, AuthData>> login(
      String username, String password) async {
    try {
      final response = await dio.post(
        ApiEndPoints.login,
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.data['success'] == true) {
        // retrive token from the response
        String token = response.data["token"];
        // await userSharedPrefs.setUserToken(token);

        AuthEntity userData = AuthEntity.fromjson(response.data['userData']);
        return Right(AuthData(userData: userData, token: token));
      } else {
        return left(Failure(
            error: response.data['message'] ?? "unknown error",
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }
}

class AuthData {
  final AuthEntity userData;
  final String token;

  AuthData({required this.userData, required this.token});
}
