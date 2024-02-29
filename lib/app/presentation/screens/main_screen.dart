import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_test/app/presentation/logic/main_screen_cubit.dart';
import 'package:webspark_test/common/widgets/submit_action_button.dart';
import 'package:webspark_test/utils/navigation/routes/app_router.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainScreenCubit>(
      create: (ctx) => MainScreenCubit(),
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<StatefulWidget> createState() => MainScreenViewState();
}

class MainScreenViewState extends State<MainScreenView> {
  late TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(14.r),
            child: const Text('Set valid API base URL in order to continue'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.r),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 17.r),
                  child: const Icon(
                    Icons.compare_arrows,
                    color: Color(0xFF898989),
                  ),
                ),
                Flexible(
                  child: BlocBuilder<MainScreenCubit, MainScreenState>(
                    builder: (context, state) {
                      return TextField(
                        controller: textController,
                        decoration: InputDecoration(
                            hintText: 'Enter Url',
                            errorText: state.validator.isValid
                                ? null
                                : state.validator.error?.errorMessage ?? ''),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(9.r),
            child: SubmitActionButton(
              caption: 'Start counting process',
              onTap: () async {
                MainScreenCubit cubit =
                    BlocProvider.of<MainScreenCubit>(context);
                if (await cubit.submit(textController.text)) {
                  if(context.mounted) {
                    AutoRouter.of(context).push(const ProcessRoute());
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
