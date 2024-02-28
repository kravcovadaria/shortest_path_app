import 'package:formz/formz.dart';

abstract class AppValidation<T extends String, E> extends FormzInput<T, E> {
  const AppValidation.dirty(super.value, {this.isRequired = true})
      : super.dirty();

  const AppValidation.pure(super.value, {this.isRequired = true}) : super.pure();

  AppValidation makeDirty([String? value]);

  AppValidation changeRequirement(bool isRequired);
  
  final bool isRequired;
}
