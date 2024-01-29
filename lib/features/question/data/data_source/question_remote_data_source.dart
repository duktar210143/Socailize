import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:discussion_forum/config/constants/api_end_points.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/network/remote/http_service.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/question/data/model/question_api_model.dart';
import 'package:discussion_forum/features/question/domain/entity/question_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionRemoteDatasourceProvider =
    Provider.autoDispose<QuestionRemoteDataSource>(
  (ref) => QuestionRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class QuestionRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  QuestionRemoteDataSource({required this.userSharedPrefs, required this.dio});

  // Add a method to set the authorization header with the token
  void _setAuthorizationHeader(String token) {
    dio.options.headers["x-access-token"] = token;
  }

  Future<Either<Failure, bool>> addQuestions(
      QuestionEntity question, File? image) async {
    print("this is controller");
    print(QuestionApiModel.fromEntity(question).toJson());
    try {
      // retrive the token from the sharedPreference
      Either<Failure, String?> token = await userSharedPrefs.getUserToken();

      token.fold(
        (failure) => false,
        (token) => _setAuthorizationHeader(token!),
      );

      QuestionApiModel questionApiModel = QuestionApiModel.fromEntity(question);

      String fileName = image!.path.split('/').last;

      FormData formData = FormData.fromMap({
        'question': questionApiModel.toJson().toString(),
        'questionImage': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });

      // var a = batchAPIModel.toJson();
      var response = await dio.post(
        ApiEndPoints.addQuestion,
        data: formData,
      );

      if (response.data['success'] == true) {
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
          error: e.error.toString(),
        ),
      );
    }
  }

  // function for get all userQuestions
}
