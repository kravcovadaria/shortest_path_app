import 'package:dio/dio.dart';
import 'package:webspark_test/shortest_path/data/models/shortest_path.dart';
import 'package:webspark_test/utils/network/api_exceptions.dart';
import 'package:webspark_test/utils/network/api_manager.dart';

abstract class IShortestPathDataSource {
  Future<List<ShortestPath>> getInputData({Map<String, dynamic>? parameters});
  Future<dynamic> postResults(List<Map<String, dynamic>> data,
      {Map<String, dynamic>? parameters});
}

class ShortestPathDataSource implements IShortestPathDataSource {
  ShortestPathDataSource(this.dio);

  final Dio dio;

  Future<List<ShortestPath>> getInputData(
      {Map<String, dynamic>? parameters}) async {
    List<ShortestPath> inputData = [];

    final response = await ApiManager().get(
      '',
      dio,
      queryParameters: parameters,
    );

    List<dynamic>? data;
    if (response?.data is List) {
      data = response?.data as List<dynamic>?;
    } else if (response?.data is Map) {
      final responseData = response?.data as Map<String, dynamic>;
      data = responseData['data'] as List<dynamic>?;
    }
    if (response?.success == true && data != null) {
      for (int i = 0; i < data.length; i += 1) {
        inputData.add(ShortestPath.fromJson(data[i] as Map<String, dynamic>));
      }
      return inputData;
    }

    throw ApiException(response);
  }

  Future<dynamic> postResults(List<Map<String, dynamic>> data,
      {Map<String, dynamic>? parameters}) async {
    final response = await ApiManager().post(
      '',
      dio,
      data: data,
      queryParameters: parameters,
    );

    if (response?.success == true) {
      return;
    }
    throw ApiException(response);
  }
}
