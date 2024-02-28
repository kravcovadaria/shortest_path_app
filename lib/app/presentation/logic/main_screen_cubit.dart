import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webspark_test/utils/app_reg_exp.dart';
import 'package:webspark_test/utils/utils.dart';
import 'package:webspark_test/utils/validators/url_validation.dart';
import 'package:webspark_test/utils/validators/validators.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState());

  Future<bool> submit(String url) async {
    bool success = false;

    UrlValidator validator = state.validator.makeDirty(url);
    emit(state.copyWith(validator: validator));
    if (state.validator.isValid) {
      try {
        /// put url to storage
        if (!Hive.isBoxOpen('urlPrefs')) {
          await Hive.openBox('urlPrefs');
        }
        var prefs = Hive.box('urlPrefs');

        int parametersPos = url.indexOf('?');
        if (parametersPos == -1) {
          prefs.put('url', url);
          prefs.put('parameters', {});
        } else {
          prefs.put('url', url.substring(0, parametersPos));
          String parametersString = url.substring(parametersPos + 1);
          List<String> StringParameterList = parametersString.split('&');
          Map<String, dynamic> parameters = {};
          for (String param in StringParameterList) {
            int eqPos = param.indexOf('=');
            parameters[param.substring(0, eqPos)] = param.substring(eqPos + 1);
          }
          prefs.put('parameters', parameters);
        }
        success = true;
      } catch (e, stack) {
        Utils.errorPrint(e.toString(), stack);
      }
    }

    return success;
  }
}
