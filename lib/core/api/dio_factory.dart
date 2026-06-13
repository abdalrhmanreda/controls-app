import 'dart:async';

import 'package:dio/dio.dart';
import 'package:control_app/core/api/api_error_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? dio;

  static Future<Dio> initDio() async {
    Duration timeout = const Duration(seconds: 30);
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = timeout;
      dio!.options.receiveTimeout = timeout;
      dio!.options.headers['Content-Type'] = 'application/json';
      addInterceptors(dio!);
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addInterceptors(Dio dio) {
    // Pretty logger
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    // Error parser — extracts the human-readable message from the API response body
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          final data = response.data;
          // Check if the application-level status code indicates an error (>= 400)
          if (data is Map && data['status'] is int && (data['status'] as int) >= 400) {
            final appStatus = data['status'] as int;
            String message = data['message']?.toString() ?? 'Unknown error';
            
            // Extract detailed error if present
            if (data['error'] != null) {
              if (data['error'] is String) {
                message = '$message ${data['error']}';
              } else if (data['error'] is Map) {
                final errorMap = data['error'] as Map;
                if (errorMap.isNotEmpty) {
                  final firstError = errorMap.values.first;
                  if (firstError is List && firstError.isNotEmpty) {
                    message = firstError.first.toString();
                  } else {
                    message = firstError.toString();
                  }
                }
              }
            }

            return handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                type: DioExceptionType.badResponse,
                error: ApiErrorModel(
                  statusCode: appStatus,
                  message: message,
                ),
              ),
            );
          }
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          final response = e.response;
          if (response != null && response.data != null) {
            final data = response.data;
            String? message;

            if (data is Map) {
              message = data['message']?.toString();
              
              if (data['error'] != null) {
                if (data['error'] is String) {
                  message = message != null ? '$message ${data['error']}' : data['error'].toString();
                } else if (data['error'] is Map) {
                  final errorMap = data['error'] as Map;
                  if (errorMap.isNotEmpty) {
                    final firstError = errorMap.values.first;
                    if (firstError is List && firstError.isNotEmpty) {
                      message = firstError.first.toString();
                    } else {
                      message = firstError.toString();
                    }
                  }
                }
              }

              message ??= (data['detail'] ?? data['msg'])?.toString();
            }

            if (message != null && message.isNotEmpty) {
              return handler.reject(
                DioException(
                  requestOptions: e.requestOptions,
                  response: e.response,
                  type: e.type,
                  error: ApiErrorModel(
                    statusCode: response.statusCode ?? 500,
                    message: message,
                  ),
                ),
              );
            }
          }
          return handler.next(e);
        },
      ),
    );
  }
}