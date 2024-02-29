import 'package:webspark_test/utils/network/api_exceptions.dart';
import 'package:webspark_test/utils/utils.dart';
import 'package:webspark_test/utils/validators/validators.dart';

class Failure {
  const Failure([String? errorMessage])
      : errorMessage = errorMessage ?? "Something went wrong";

  /// Message to display for user
  final String errorMessage;

  factory Failure.from(
    Object e,
    StackTrace? stack,
  ) {
    Utils.errorPrint(e, stack);

    if (e is ApiException) return Failure(e.message);
    return const Failure();
  }
}

class AllRight extends Failure {
  const AllRight() : super('');

  @override
  String get errorMessage => '';
}
