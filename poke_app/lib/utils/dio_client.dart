import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '/constants/urls.dart';


class DioClient {
  static final _dioClient = DioClient._();
  late final Dio _dio;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._() {
    _dio = Dio();
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          requestBody: true,
        ),
      );
    }
  }

  final timeOutDuration = const Duration(seconds: 300);

  Future<Response> request() async {
    try {
      final resp = await _dio
          .get(
            AppUrls.indexUrl,
          )
          .timeout(
            timeOutDuration,
          );
      return resp;
    } on DioException {
      throw "Cannot get data";
    } catch (ex) {
      rethrow;
    }
  }
}
