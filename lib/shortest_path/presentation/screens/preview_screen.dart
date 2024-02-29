import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webspark_test/shortest_path/data/models/path_point.dart';
import 'package:webspark_test/shortest_path/data/models/shortest_path.dart';

@RoutePage()
class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.result});

  final ShortestPath result;

  @override
  Widget build(BuildContext context) {
    int gridSize = result.field.length;
    double cellSize = (MediaQueryData.fromView(View.of(context)).size.width -
            10 -
            2 * gridSize) /
        gridSize;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: pow(gridSize, 2) as int,
            itemBuilder: (context, index) {
              PathPoint curPoint =
                  PathPoint(index % gridSize, (index ~/ gridSize));
              Color? containerColor;
              Color? textColor = Colors.black;

              if (curPoint == result.start) {
                containerColor = const Color(0xFF64FFDA);
              } else if (curPoint == result.end) {
                containerColor = const Color(0xFF009688);
              } else if (result.steps.contains(curPoint)) {
                containerColor = const Color(0xFF4CAF50);
              } else if (!result.field[curPoint.y][curPoint.x]) {
                containerColor = const Color(0xFF000000);
                textColor = Colors.white;
              } else {
                containerColor = Colors.white;
              }
              return Container(
                alignment: Alignment.center,
                height: cellSize,
                width: cellSize,
                decoration: BoxDecoration(
                  color: containerColor,
                  border: Border(
                    right: BorderSide(
                      width: 2.0,
                    ),
                    bottom: BorderSide(
                      width: 2.0,
                    ),
                  ),
                ),
                child: Text(
                  '(${curPoint.x},${curPoint.y})',
                  style: TextStyle(color: textColor),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
            ),
          ),
          Text('$result'),
        ],
      ),
    );
  }
}
