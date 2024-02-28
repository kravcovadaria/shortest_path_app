part of 'path_calculation_cubit.dart';

enum PathCalculationStatus { initial, loading, success, failure }

class PathCalculationState extends Equatable {
  const PathCalculationState({
    this.status = PathCalculationStatus.initial,
    this.progress = 0,
    this.error = const AllRight(),
  });

  final PathCalculationStatus status;
  final double progress;
  final Failure error;

  PathCalculationState copyWith({
    PathCalculationStatus? status,
    double? progress,
    Failure? error,
  }) {
    return PathCalculationState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      /// if error is not provided, it means, some new calculation is going on
      /// if we had error earlier, remove it
      error: error ?? AllRight(),
    );
  }

  @override
  List<Object> get props => [status, progress];
}
