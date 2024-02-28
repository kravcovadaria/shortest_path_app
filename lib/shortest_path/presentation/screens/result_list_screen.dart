import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webspark_test/shortest_path/data/models/shortest_path.dart';
import 'package:webspark_test/utils/navigation/routes/app_router.dart';

@RoutePage()
class ResultListScreen extends StatefulWidget {
  const ResultListScreen({super.key});

  @override
  State<StatefulWidget> createState() => ResultListScreenState();
}

class ResultListScreenState extends State<ResultListScreen> {
  final ScrollController controller = ScrollController();
  late Box<ShortestPath> hiveBox;

  @override
  void initState() {
    super.initState();
    hiveBox = Hive.box<ShortestPath>('paths');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: hiveBox.listenable(),
            builder: (context, box, widget) {
              return Expanded(
                child: ListView.builder(
                  itemCount: hiveBox.length,
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    ShortestPath _element = hiveBox.getAt(index)!;
                    return InkWell(
                      onTap: () {
                        AutoRouter.of(context)
                            .push(PreviewRoute(result: _element));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: 20.r,
                          horizontal: 10.r,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFDFDFDF),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Text(
                          _element.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
