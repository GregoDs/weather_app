import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout, please try again.";
        case DioExceptionType.receiveTimeout:
          return "Server is taking too long to respond.";
        case DioExceptionType.badResponse:
          return "Invalid response from server.";
        default:
          return "Something went wrong.";
      }
    }
    return "Unexpected error occurred.";
  }
}