import 'package:webspark_test/utils/app_reg_exp.dart';
import 'package:webspark_test/utils/failures/failure.dart';
import 'package:webspark_test/utils/validators/app_validation.dart';

abstract class UrlErrors implements Failure {}

class EmptyUrl extends UrlErrors {
  @override
  String get errorMessage => 'URL is empty';
}

class InvalidUrl extends UrlErrors {
  @override
  String get errorMessage => 'URL is not valid';
}

class UrlValidator extends AppValidation<String, UrlErrors> {
  const UrlValidator.pure([String? value, bool isRequired = true])
      : super.pure(value ?? '', isRequired: isRequired);

  const UrlValidator.dirty([String? value, bool isRequired = true])
      : super.dirty(value ?? '', isRequired: isRequired);

  @override
  UrlValidator makeDirty([String? value]) {
    return UrlValidator.dirty(value ?? this.value, isRequired);
  }

  @override
  UrlValidator changeRequirement(bool isRequired) {
    return UrlValidator.dirty(value, isRequired);
  }

  @override
  UrlErrors? validator(String value) {
    if (isPure) return null;
    if (value.trim().isEmpty && isRequired) {
      return EmptyUrl();
    } else if (value.trim().isNotEmpty && !AppRegExp.url.hasMatch(value)) {
      return InvalidUrl();
    } else {
      return null;
    }
  }
}
