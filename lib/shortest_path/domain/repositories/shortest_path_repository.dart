import 'package:webspark_test/shortest_path/data/datasources/shortest_path_datasource.dart';
import 'package:webspark_test/shortest_path/data/models/shortest_path.dart';
import 'package:webspark_test/utils/failures/failure.dart';

abstract class IShortestPathRepository {
  Future<({List<ShortestPath> paths, Failure failure})> getInputData(
      {Map<String, dynamic>? parameters});
  Future<dynamic> postResults(List<Map<String, dynamic>> data,
      {Map<String, dynamic>? parameters});
}

class ShortestPathRepository implements IShortestPathRepository {
  ShortestPathRepository(this._dataSource);
  final IShortestPathDataSource _dataSource;

  Future<({List<ShortestPath> paths, Failure failure})> getInputData(
      {Map<String, dynamic>? parameters}) async {
    try {
      List<ShortestPath> inputData =
          await _dataSource.getInputData(parameters: parameters);
      return (paths: inputData, failure: AllRight());
    } catch (e, stack) {
      return (paths: <ShortestPath>[], failure: Failure.from(e, stack));
    }
  }

  Future<dynamic> postResults(List<Map<String, dynamic>> data,
      {Map<String, dynamic>? parameters}) async {
    try {
      await _dataSource.postResults(data, parameters: parameters);
      return true;
    } catch (e, stack) {
      return Failure.from(e, stack);
    }
  }
}
