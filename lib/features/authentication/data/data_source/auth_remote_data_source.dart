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

  Future<Either<Failure, bool>> login(String username, String password) async {
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
        await userSharedPrefs.setUserToken(token);

        AuthEntity userData = AuthEntity.fromjson(response.data['userData']);

        await userSharedPrefs.setUserData(userData);

        // Get the user data stored in SharedPreferences
      final storedUserData = await userSharedPrefs.getUserData();

      // Use fold to handle the Either type
      storedUserData.fold(
        (failure) {
          // Handle failure case
          print('Error retrieving user data: ${failure.error}');
        },
        (authEntity) {
          // Handle success case
          print('User data stored in SharedPreferences: $authEntity');
        },
      );

        return const Right(true);
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

  Future<Either<Failure, List<AuthApiModel>>> getUserDetails(int page) async {
    try {
      final response =
          await dio.get(ApiEndPoints.userDetails, queryParameters: {
        'page': page,
        'limit': ApiEndPoints.limitPage,
      });

      final data = response.data;

      // Check if the "success" key is true
      if (data['success'] == true) {
        // Check if the "users" key is present and is a List
        if (data['users'] is List) {
          final usersList = data['users'] as List;

          // Map the list of users to AuthApiModel
          final userdata =
              usersList.map((user) => AuthApiModel.fromJson(user)).toList();

          return right(userdata);
        } else {
          // Handle the case where "users" key is not a List
          return Left(Failure(
              error: 'Unexpected data format - "users" key is not a List'));
        }
      } else {
        // Handle the case where "success" key is not true
        return Left(Failure(error: 'API call was not successful'));
      }
    } on DioException catch (err) {
      return Left(Failure(error: err.error.toString()));
    }
  }
}
