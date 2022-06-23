import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_task/helpers/app_constants.dart';

import 'logging_interceptor.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = 30000
      ..options.receiveTimeout = 30000
      ..options.sendTimeout = 30000
      ..httpClientAdapter;
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        '${AppConstants.baseUrl}$path',
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
