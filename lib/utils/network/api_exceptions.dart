import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException(this.response);

  final Response? response;

  String? get message {
    final data = response?.data;
    if (data is! Map<String, dynamic>?) return null;
    return data?["message"];
  }
}
