import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:webspark_test/shortest_path/data/models/path_point.dart';

part 'shortest_path.g.dart';

@HiveType(typeId: 0)
class ShortestPath {
  ShortestPath({
    required this.id,
    required this.start,
    required this.end,
    required this.field,
    this.steps = const [],
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final PathPoint start;
  @HiveField(2)
  final PathPoint end;

  /// has [y][x] indexes
  @HiveField(3)
  final List<List<bool>> field;
  @HiveField(4)
  final List<PathPoint> steps;

  @override
  String toString() {
    String result = '';
    if (steps.isNotEmpty) {
      result = steps.firstOrNull.toString();
      for (int i = 1; i < steps.length; i += 1) {
        result = '$result=>${steps[i]}';
      }
    } else {
      result = 'Couldn\'t compute path';
    }
    return result;
  }

  ShortestPath copyWith({
    String? id,
    PathPoint? start,
    PathPoint? end,
    List<List<bool>>? field,
    List<PathPoint>? steps,
  }) {
    return ShortestPath(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      field: field ?? this.field,
      steps: steps ?? this.steps,
    );
  }

  factory ShortestPath.fromJson(Map<String, dynamic> json) {
    {
      var start = json['start'] as Map<String, dynamic>;
      var end = json['end'] as Map<String, dynamic>;
      var fieldStringRows = json['field'] as List<String>? ?? [];
      List<List<bool>> field = [];
      for (String fieldStringRow in fieldStringRows) {
        List<bool> fieldRow = [];
        for (String sym in fieldStringRow.characters) {
          fieldRow.add(sym == '.');
        }
        field.add(fieldRow);
      }
      return ShortestPath(
        id: json['id'] as String? ?? '',
        start: PathPoint(start['x'] as int? ?? 0, start['y'] as int? ?? 0),
        end: PathPoint(end['x'] as int? ?? 0, end['y'] as int? ?? 0),
        field: field,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': steps,
      },
      'path': this.toString(),
    };
  }
}
