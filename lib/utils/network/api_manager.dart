import 'package:dio/dio.dart';

class ApiManager {
  static Dio getDio(String url) {
    return Dio()
      ..options = BaseOptions(
        baseUrl: url,
        headers: {'content-type': 'application/json'},
        validateStatus: (_) => true,
      );
  }

  Future<Response?> get(
    String path,
    Dio dio, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response?> post(
    String path,
    Dio dio, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response?> put(
    String path,
    Dio dio, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    return await dio.put(
      path,
      data: data,
      options: options,
    );
  }

  Future<Response?> patch(
    String path,
    Dio dio, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    return await dio.patch(
      path,
      data: data,
      options: options,
    );
  }

  Future<Response?> delete(
    String path,
    Dio dio, {
    Options? options,
  }) async {
    return await dio.delete(
      path,
      options: options,
    );
  }
}

extension ResponseExtension on Response {
  bool get success {
    final code = statusCode ?? 0;
    return code == 200;
  }
}