part of 'main_screen_cubit.dart';

class MainScreenState {
  const MainScreenState({
    this.validator = const UrlValidator.pure(''),
  });

  final UrlValidator validator;

  MainScreenState copyWith({UrlValidator? validator}) {
    return MainScreenState(validator: validator ?? this.validator);
  }
}
