import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:discussion_forum/config/constants/api_end_points.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/network/remote/http_service.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/question/data/dto/get_all_questions_dto.dart';
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

// function to add question to the application
  Future<Either<Failure, bool>> addQuestions(
      QuestionEntity question, File? image) async {
    try {
      // Retrieve the token from the sharedPreference
      Either<Failure, String?> token = await userSharedPrefs.getUserToken();

      token.fold(
        (failure) => false,
        (token) => _setAuthorizationHeader(token!),
      );

      QuestionApiModel questionApiModel = QuestionApiModel.fromEntity(question);

      FormData formData = FormData.fromMap({
        'question': questionApiModel.question,
        'questionImage': image != null
            ? await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
              )
            : null,
      });

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

  // function to fetch all the question specific to the user from the application
  Future<Either<Failure, List<QuestionEntity>>> getAllQuestions() async {
    try {
      Either<Failure, String?> token = await userSharedPrefs.getUserToken();

      token.fold(
        (failure) => false,
        (token) => _setAuthorizationHeader(token!),
      );

      var response = await dio.get(ApiEndPoints.getAllquestion);
      if (response.data['success'] == true) {
        GetAllQuestionsDto getAllQuestionsDto =
            GetAllQuestionsDto.fromJson(response.data);
        // convert questionAPImodel fetched from server to entity compatible to dart
        List<QuestionEntity> lstquestions = getAllQuestionsDto.questions
            .map((question) => QuestionApiModel.toEntity(question))
            .toList();

        return right(lstquestions);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  // every questions asked by every users
  Future<Either<Failure, List<QuestionEntity>>>
      getAllPublicUserQuestions() async {
    try {
      var response = await dio.get(ApiEndPoints.getAllPublicQuestions);
      if (response.data['success'] == true) {
        GetAllQuestionsDto getAllQuestionsDto =
            GetAllQuestionsDto.fromJson(response.data);

        // convert the lst of question into entity
        List<QuestionEntity> lstQuestions = getAllQuestionsDto.questions
            .map((question) => QuestionApiModel.toEntity(question))
            .toList();

        return right(lstQuestions);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  // dio http delete request handler
  Future<Either<Failure, bool>> deleteQuestion(String questionId) async {
    try {
      Either<Failure, String?> token = await userSharedPrefs.getUserToken();

      token.fold(
        (failure) => false,
        (token) => _setAuthorizationHeader(token!),
      );

      var response = await dio.delete(
        ApiEndPoints.deletequestion + questionId,
      );
      if (response.data['success'] == true) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()
          ),
        );
      }
    }on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
