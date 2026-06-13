import 'package:dio/dio.dart';
import 'package:control_app/core/api/api_error_model.dart';

extension ErrorExtension on Object {
  String get error {
    final e = this;
    if (e is DioException) {
      if (e.error is ApiErrorModel) {
        return (e.error as ApiErrorModel).message;
      }
      if (e.response?.data is Map) {
        final data = e.response!.data as Map;
        return data['message']?.toString() ?? data['error']?.toString() ?? e.message ?? 'Unknown error';
      }
      return e.message ?? 'Unknown error';
    }
    return e.toString();
  }
}
