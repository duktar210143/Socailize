import 'package:dio/dio.dart';
import 'package:discussion_forum/config/constants/api_end_points.dart';
import 'package:discussion_forum/core/network/remote/dio_error_intercepter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
final httpServiceProvider = Provider.autoDispose<Dio>
((ref) => HttpService(Dio()).dio);

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndPoints.baseUrl
      ..options.connectTimeout = ApiEndPoints.connectionTimeOut
      ..options.receiveTimeout = ApiEndPoints.receivedTimeOut
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseBody: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      };
  }
}
