import 'package:dio/dio.dart';
import 'package:flutter_task/helpers/app_constants.dart';
import 'package:flutter_task/model/responses/api_response.dart';
import 'package:flutter_task/remote/dio/api_client.dart';
import 'package:flutter_task/remote/exception/api_error_handler.dart';

class NetworkRepo {
  Future<ApiResponse> getUsers() async {
    try {
      Response response = await ApiClient().get(AppConstants.usersPath);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
