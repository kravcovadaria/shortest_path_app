import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:webspark_test/shortest_path/data/datasources/shortest_path_datasource.dart';
import 'package:webspark_test/shortest_path/data/models/shortest_path.dart';
import 'package:webspark_test/shortest_path/domain/repositories/shortest_path_repository.dart';
import 'package:webspark_test/utils/failures/failure.dart';
import 'package:webspark_test/utils/network/api_manager.dart';
import 'package:webspark_test/utils/shortest_path_calculator.dart';
import 'package:webspark_test/utils/utils.dart';

part 'path_calculation_state.dart';

class PathCalculationCubit extends Cubit<PathCalculationState> {
  PathCalculationCubit() : super(const PathCalculationState());

  late ShortestPathRepository repository;

  void startCalculation() async {
    emit(state.copyWith(status: PathCalculationStatus.loading));

    var prefs = Hive.box('urlPrefs');

    /// evoke url from storage
    String url = prefs.get('url') ?? '';
    Map<String, dynamic> parameters = prefs.get('parameters') ?? {};

    if (!Hive.isBoxOpen('paths')) {
      await Hive.openBox<ShortestPath>('paths');
    }
    final hiveBox = Hive.box<ShortestPath>('paths');

    repository = ShortestPathRepository(
      ShortestPathDataSource(
        ApiManager.getDio(url),
      ),
    );

    ({List<ShortestPath> paths, Failure failure}) apiResult =
        await repository.getInputData(parameters: parameters);
    if (apiResult.paths.isNotEmpty) {
      double delta = 100 / apiResult.paths.length;
      List<ShortestPath> result = [];

      for (ShortestPath path in apiResult.paths) {
        ShortestPathCalculator calculator = ShortestPathCalculator(
          start: path.start,
          end: path.end,
          field: path.field,
        );
        ShortestPath computedPath =
            path.copyWith(steps: calculator.calculateTheShortestPath());
        result.add(computedPath);
        emit(state.copyWith(progress: state.progress + delta));
      }

      await hiveBox.clear();
      await hiveBox.addAll(result);
      emit(state.copyWith(status: PathCalculationStatus.success));
    } else if (!(apiResult.failure is AllRight)) {
      emit(state.copyWith(
        error: apiResult.failure,
        status: PathCalculationStatus.failure,
      ));
    }
  }

  Future<bool> submit() async {
    bool result = false;
    List<Map<String, dynamic>> data = [];
    var prefs = Hive.box('urlPrefs');
    Map<String, dynamic> parameters = prefs.get('parameters') ?? {};

    try {
      repository.postResults(data, parameters: parameters);
       result = true;
    } catch (e, stack) {
      Utils.errorPrint(e, stack);
      emit(state.copyWith(error: Failure.from(e, stack)));
    }

    return result;
  }
}
