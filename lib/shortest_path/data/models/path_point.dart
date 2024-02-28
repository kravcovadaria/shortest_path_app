import 'package:hive/hive.dart';

part 'path_point.g.dart';

@HiveType(typeId: 1)
class PathPoint {
  PathPoint(
    this.x,
    this.y,
  );

  @HiveField(0)
  final int x;
  @HiveField(1)
  final int y;

  @override
  String toString() => '($x,$y)';

  @override
  bool operator ==(covariant PathPoint point) {
    if (identical(this, point)) {
      return true;
    }
    return this.x == point.x && this.y == point.y;
  }

  factory PathPoint.fromJson(Map<String, dynamic> json) {
    {
      return PathPoint(
        json['x'] as int? ?? 0,
        json['y'] as int? ?? 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "x": x,
      "y": y,
    };
  }
}
