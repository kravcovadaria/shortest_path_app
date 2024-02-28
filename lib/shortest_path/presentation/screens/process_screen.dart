import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_test/common/widgets/submit_action_button.dart';
import 'package:webspark_test/utils/navigation/routes/app_router.dart';

import '../logic/computing_process/path_calculation_cubit.dart';

@RoutePage()
class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PathCalculationCubit>(
      create: (context) => PathCalculationCubit()..startCalculation(),
      child: const ProcessView(),
    );
  }
}

class ProcessView extends StatelessWidget {
  const ProcessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process screen'),
      ),
      body: BlocBuilder<PathCalculationCubit, PathCalculationState>(
        builder: (context, state) {
          String progressorText = switch (state.status) {
            PathCalculationStatus.loading => 'Calculation in process',
            PathCalculationStatus.success =>
              'All calculations has finished, you can send your result to server',
            PathCalculationStatus.failure ||
            PathCalculationStatus.initial =>
              'Something went wrong',
          };
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(14.r),
                      child: Text(
                        progressorText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (state.status == PathCalculationStatus.loading ||
                        state.status == PathCalculationStatus.success)
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.r),
                        child: Text('${state.progress.toStringAsFixed(2)}%'),
                      ),
                    if (state.status == PathCalculationStatus.loading ||
                        state.status == PathCalculationStatus.success)
                      SizedBox(
                        height: 100.r,
                        width: 100.r,
                        child: CircularProgressIndicator(
                          value: state.progress / 100,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(9.r),
                child: SubmitActionButton(
                  caption: 'Send results to server',
                  onTap: state.status != PathCalculationStatus.success
                      ? null
                      : () async {
                          PathCalculationCubit cubit =
                              BlocProvider.of<PathCalculationCubit>(context);
                          bool success = await cubit.submit();
                          if (context.mounted && success) {
                            AutoRouter.of(context).push(ResultListRoute());
                          }
                        },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
