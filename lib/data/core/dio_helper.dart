import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:posts_app/core/constants/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum Method { post, get, put, delete, patch }

extension DioErrorExtensions on DioError {
  String get errorMessage {
    return response?.data['status_message'] ?? message;
  }
}

class DioHelper {
  late Dio _dio;

  static const _timeOut = 60000;

  DioHelper() {
    final options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      sendTimeout: _timeOut,
    );
    _dio = Dio(options);
    _initInterceptors();
  }

  void _initInterceptors() {
    if (!kReleaseMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }

  Future<dynamic> request({
    required String endpoint,
    required Method method,
    Map<String, dynamic>? params,
  }) async {
    late Response response;

    try {
      if (method == Method.post) {
        response = await _dio.post(endpoint, data: params);
      } else if (method == Method.delete) {
        response = await _dio.delete(endpoint);
      } else if (method == Method.patch) {
        response = await _dio.patch(endpoint, data: params);
      } else {
        response = await _dio.get(endpoint, queryParameters: params);
      }
    } on DioError {
      rethrow;
    }

    return response.data;
  }
}
