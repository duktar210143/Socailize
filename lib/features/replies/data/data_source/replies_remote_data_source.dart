import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:discussion_forum/config/constants/api_end_points.dart';
import 'package:discussion_forum/core/failure/failure.dart';
import 'package:discussion_forum/core/network/remote/http_service.dart';
import 'package:discussion_forum/core/network/remote/socket_service.dart';
import 'package:discussion_forum/core/shared_pref/user_shared_prefs.dart';
import 'package:discussion_forum/features/replies/data/dto/get_question_specific_replies_dto.dart';
import 'package:discussion_forum/features/replies/data/model/reply_api_model.dart';
import 'package:discussion_forum/features/replies/domain/entity/replies_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final replyRemoteDataSourceProvider = Provider<ReplyRemoteDataSource>((ref) {
  return ReplyRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider),
      socketService: ref.read(socketServiceProvider));
});

class ReplyRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final SocketService socketService;

  ReplyRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
    required this.socketService,
  });

  // Add a method to set the authorization header with the token
  void _setAuthorizationHeader(String token) {
    dio.options.headers["x-access-token"] = token;
  }

  Future<Either<Failure, bool>> addReply(
    String questionId,
    ReplyEntity entity,
  ) async {
    try {
      Either<Failure, String?> token = await userSharedPrefs.getUserToken();

      token.fold(
        (failure) => false,
        (token) => _setAuthorizationHeader(token!),
      );

      ReplyApiModel replyApiModel = ReplyApiModel.fromEntity(entity);

      String url = '${ApiEndPoints.setUserSpecificReplies}/$questionId';

      var response = await dio.post(
        url,
        data: replyApiModel.toJson(),
      );

      if (response.data['success'] == true) {
        var replyData = {
          'reply': response.data['reply']['question'],
          'users': response.data['users'],
        };
        var user = response.data['reply']['user'];

        socketService.connect();
        socketService.setup(user);
        // Emit a new reply event to the socket server
        socketService.sendNewReply(replyData);

        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioError catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  // Method to fetch replies specific to questions
  Future<Either<Failure, List<ReplyEntity>>> getUserSpecificReplies(
      String questionId) async {
    try {
      Either<Failure, String?> token = await userSharedPrefs.getUserToken();

      token.fold(
        (failure) => false,
        (token) => _setAuthorizationHeader(token!),
      );

      String url = '${ApiEndPoints.getUserSpecificReplies}/$questionId';

      var response = await dio.get(
        url,
      );

      if (response.data['success'] == true) {
        GetQuestionSpecificRepliesDto getQuestionSpecificRepliesDto =
            GetQuestionSpecificRepliesDto.fromJson(response.data);

        //  convert the lsit of replies fetched from the seerver into entity
        List<ReplyEntity> lstReplies = getQuestionSpecificRepliesDto.replies
            .map((replies) => ReplyApiModel.toEntity(replies))
            .toList();



        return right(lstReplies);
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
}
