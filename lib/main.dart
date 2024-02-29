import 'package:hive_flutter/adapters.dart';
import 'package:webspark_test/app/presentation/screens/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_test/shortest_path/data/models/path_point.dart';
import 'package:webspark_test/shortest_path/data/models/shortest_path.dart';

final appKey = GlobalKey<NavigatorState>();

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(ShortestPathAdapter());
  Hive.registerAdapter(PathPointAdapter());

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ScreenUtilInit(
      designSize: const Size(412, 877),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return App(key: appKey);
      },
    ),
  );
}
