import 'dart:math';

import 'package:webspark_test/shortest_path/data/models/path_point.dart';

class ShortestPathCalculator {
  const ShortestPathCalculator({
    required this.start,
    required this.end,
    required this.field,
  });

  final PathPoint start;
  final PathPoint end;
  final List<List<bool>> field;

  List<PathPoint> calculateTheShortestPath() {
    List<PathPoint> steps = [];
    List<List<bool>> _field = //[for (final it in field) List.from(it)];
        _closeDeadlocks(start, end);

    steps.add(start);
    int x = 0;
    int y = 0;
    int destX = end.x;
    int destY = end.y;
    int lastIndex = field.length - 1;
    bool complete = false;
    while (!complete) {
      /// movement in the direction of an end has the highest priority
      /// diagonal move is the best if possible

      x = steps.last.x;
      y = steps.last.y;

      PathPoint? nextPoint;
      if (x < destX) {
        nextPoint = _tryMoveXRight(x, y, destY, lastIndex, _field);
      } else if (x > destX) {
        nextPoint = _tryMoveXLeft(x, y, destY, lastIndex, _field);
      } else {
        nextPoint = _tryMoveSameX(x, y, destY, lastIndex, _field);
      }
      if (nextPoint == null ||
          (steps.isNotEmpty && steps.contains(nextPoint))) {
        if (x > destX) {
          nextPoint = _tryMoveXRight(x, y, destY, lastIndex, _field);
        } else {
          nextPoint = _tryMoveXLeft(x, y, destY, lastIndex, _field);
        }
      }

      if (nextPoint == null || (steps.isNotEmpty && nextPoint == steps.last)) {
        /// cannot to go further
        if (steps.isEmpty) {
          /// impossible to reach ending point
          complete = true;
        } else {
          /// go back, mark the current point as not accessible,
          /// so algorithm couldn't make the same mistake
          PathPoint prevPoint = steps.last;
          _field[prevPoint.y][prevPoint.x] = false;
          steps.removeLast();
          if (steps.isEmpty) {
            /// impossible to reach ending point
            complete = true;
          }
        }
      } else if (steps.contains(nextPoint)) {
        /// we somehow backtracked, so we need to:
        ///    - truncate to this point
        ///    - disable the next point to prevent the same mistake
        int index = steps.indexOf(nextPoint);
        _field[y][x] = false;
        if (index + 1 == steps.length - 1) {
          steps.removeLast();
        } else {
          steps.removeRange(index + 1, steps.length - 1);
        }
      } else if (nextPoint.x == destX && nextPoint.y == destY) {
        steps.add(nextPoint);
        steps = _optimize(steps);
        complete = true;
      } else {
        /// go further
        steps.add(nextPoint);
      }
    }

    return steps;
  }

  PathPoint? _tryMoveY(
      int x, int y, int destY, int lastIndex, List<List<bool>> _field,
      [bool sameX = false]) {
    PathPoint? nextPoint;
    if (y < destY && y != lastIndex && _field[y + 1][x]) {
      /// the most optimal move #1
      nextPoint = PathPoint(x, y + 1);
    } else if (y > destY && y != 0 && _field[y - 1][x]) {
      /// the most optimal move #2
      nextPoint = PathPoint(x, y - 1);
    } else if (!sameX && _field[y][x]) {
      /// less optimal move #1 if not on the same line
      /// ignore for vertical movement
      nextPoint = PathPoint(x, y);
    } else if (y < destY && y != 0 && _field[y - 1][x]) {
      /// the least optimal move #1
      nextPoint = PathPoint(x, y - 1);
    } else if (y > destY && y != lastIndex && _field[y + 1][x]) {
      /// the least optimal move #2
      nextPoint = PathPoint(x, y + 1);
    }

    return nextPoint;
  }

  PathPoint? _tryMoveXRight(
    int x,
    int y,
    int destY,
    int lastIndex,
    List<List<bool>> _field,
  ) {
    PathPoint? nextPoint;

    /// the most optimal - try right
    if (x < lastIndex) {
      nextPoint = _tryMoveY(x + 1, y, destY, lastIndex, _field);
    }

    /// less optimal - try the same x
    if (nextPoint == null) {
      nextPoint = _tryMoveY(x, y, destY, lastIndex, _field);
    }

    /// the least optimal - try left
    if (nextPoint == null && x > 0) {
      nextPoint = _tryMoveY(x - 1, y, destY, lastIndex, _field);
    }

    return nextPoint;
  }

  PathPoint? _tryMoveXLeft(
    int x,
    int y,
    int destY,
    int lastIndex,
    List<List<bool>> _field,
  ) {
    PathPoint? nextPoint;

    /// the most optimal - try left
    if (x > 0) {
      nextPoint = _tryMoveY(x - 1, y, destY, lastIndex, _field);
    }

    /// less optimal - try the same x
    if (nextPoint == null) {
      nextPoint = _tryMoveY(x, y, destY, lastIndex, _field);
    }

    /// the least optimal - try right
    if (nextPoint == null && x < lastIndex) {
      nextPoint = _tryMoveY(x + 1, y, destY, lastIndex, _field);
    }

    return nextPoint;
  }

  PathPoint? _tryMoveSameX(
    int x,
    int y,
    int destY,
    int lastIndex,
    List<List<bool>> _field,
  ) {
    PathPoint? nextPoint;

    /// the most optimal - try the same x
    nextPoint = _tryMoveY(x, y, destY, lastIndex, _field, true);

    /// less optimal #1 - try right
    if (nextPoint == null && x < lastIndex) {
      nextPoint = _tryMoveY(x + 1, y, destY, lastIndex, _field);
    }

    /// less optimal #2 - try left
    if (nextPoint == null && x > 0) {
      nextPoint = _tryMoveY(x - 1, y, destY, lastIndex, _field);
    }

    return nextPoint;
  }

  List<List<bool>> _closeDeadlocks(start, end) {
    List<List<bool>> _field = [for (final it in field) List.from(it)];

    /// let us find deadlocks in rows and fill them as not accessible
    if (start.y != end.y) {
      int xMin = min(start.x, end.x);
      int xMax = max(start.x, end.x);
      if (xMax - xMin > 1) {
        for (int rowIndex = min(start.y + 1, end.y + 1);
            rowIndex < max(start.y, end.y);
            rowIndex += 1) {
          List<bool> row = _field[rowIndex];
          if (!row.sublist(xMin, xMax).contains(true)) {
            for (int cell = 0; cell >= 0; cell -= 1) {
              if (!row[cell]) {
                xMin -= 1;
              } else {
                break;
              }
            }
            for (int cell = 0; cell < _field.length; cell += 1) {
              if (!row[cell]) {
                xMax += 1;
              } else {
                break;
              }
            }

            /// now we find and fill ranges where
            /// we want to discourage algorithm to go
            int deltaY = rowIndex > start.y ? -1 : 1;
            for (int j = rowIndex + deltaY;
                deltaY < 0 ? j >= 0 : j < _field.length;
                j += deltaY) {
              List searchRow = _field[j].sublist(xMin, xMax);
              if (searchRow.contains(false)) {
                int indexF = searchRow.indexOf(false);
                _field[j].fillRange(
                    min(indexF, start.x), max(indexF, start.x), false);
              } else {
                break;
              }
            }
          }
        }
      }
    }

    /// let us find deadlocks in columns and fill them as not accessible
    List<List<bool>> _transposedField = _transposeField(_field);
    if (start.x != end.x) {
      int yMin = min(start.y, end.y);
      int yMax = max(start.y, end.y);
      if (yMax - yMin > 1) {
        for (int columnIndex = min(start.x + 1, end.x + 1);
            columnIndex < max(start.x, end.x);
            columnIndex += 1) {
          List<bool> column = _transposedField[columnIndex];
          if (!column.sublist(yMin, yMax).contains(true)) {
            for (int cell = 0; cell >= 0; cell -= 1) {
              if (!column[cell]) {
                yMin -= 1;
              } else {
                break;
              }
            }
            for (int cell = 0; cell < _transposedField.length; cell += 1) {
              if (!column[cell]) {
                yMax += 1;
              } else {
                break;
              }
            }

            /// now we find and fill ranges where
            /// we want to discourage algorithm to go
            int deltaX = columnIndex > start.x ? -1 : 1;
            for (int j = columnIndex + deltaX;
                deltaX < 0 ? j >= 0 : j < _transposedField.length;
                j += deltaX) {
              List searchColumn = _transposedField[j].sublist(yMin, yMax);
              if (searchColumn.contains(false)) {
                int indexF = searchColumn.indexOf(false);
                for (int l = min(indexF, start.y);
                    l < max(indexF, start.y);
                    l += 1) {
                  _field[l][j] = false;
                }
              } else {
                break;
              }
            }
          }
        }
      }
    }

    return _field;
  }

  List<List<bool>> _transposeField(List<List<bool>> _field) {
    if (_field.isEmpty) {
      return _field;
    }
    return [
      for (var i = 0; i < _field.length; i += 1)
        [for (var j = 0; j < _field.length; j += 1) _field[j][i]]
    ];
  }

  List<PathPoint> _optimize(List<PathPoint> steps) {
    List<int> delete = [];
    for (int pointIndex = 0; pointIndex < steps.length; pointIndex += 1) {
      PathPoint point = steps[pointIndex];

      int? sameXIndex = steps.indexWhere(
        (element) => element.x == point.x && element != point,
        pointIndex,
      );
      if (sameXIndex > -1) {
        int minY = min(point.y, steps[sameXIndex].y);
        int maxY = max(point.y, steps[sameXIndex].y);
        bool hasWall = false;
        for (int j = minY; j < maxY; j += 1) {
          hasWall = hasWall || !field[j][point.x];
        }
        if (!hasWall) {
          for (int i = pointIndex + 1; i < sameXIndex; i += 1) {
            steps[i] = PathPoint(point.x, steps[i].y);
          }
        }
      }

      int? sameYIndex = steps.indexWhere(
            (element) => element.y == point.y && element != point,
        pointIndex,
      );
      if (sameYIndex > -1) {
        int minX = min(point.x, steps[sameYIndex].x);
        int maxX = max(point.x, steps[sameYIndex].x);
        if (!field[point.y].sublist(minX, maxX).contains(false)) {
          for (int i = pointIndex + 1; i < sameYIndex; i += 1) {
            steps[i] = PathPoint(steps[i].x, point.y);
          }
        }
      }

      if (pointIndex != 0 && steps[pointIndex] == steps[pointIndex - 1]) {
        delete.add(pointIndex);
      }
    }

    /// cleanup
    for (int i = delete.length; i > 0; i -= 1) {
      steps.removeAt(delete[i - 1]);
    }

    return steps;
  }
}
