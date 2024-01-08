import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:discussion_forum/config/constants/api_end_points.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/network/remote/http_service.dart';
import 'package:discussion_forum/features/authentication/data/models/auth_api_model.dart';
import 'package:discussion_forum/features/authentication/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSoureProvider = Provider.autoDispose<AuthRemoteDataSource>
((ref) => AuthRemoteDataSource(dio: ref.read(httpServiceProvider)));

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  Future<Either<Failure, bool>> signUpUser(AuthEntity entity) async {
    print(AuthApiModel.fromEntity(entity).toJson());
    try {
      AuthApiModel authApiModel = AuthApiModel.fromEntity(entity);

      var response =
          await dio.post(ApiEndPoints.signUp, data: authApiModel.toJson());

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }
}
