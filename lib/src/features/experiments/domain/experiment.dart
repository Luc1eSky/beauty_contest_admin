import 'package:freezed_annotation/freezed_annotation.dart';

part 'experiment.freezed.dart';
part 'experiment.g.dart';

@freezed
class Experiment with _$Experiment {
  const factory Experiment({
    required String name,
    required String location,
    required ExperimentStatus status,
    required DateTime createdOn,
  }) = _Experiment;
  factory Experiment.fromJson(Map<String, dynamic> json) => _$ExperimentFromJson(json);
}

enum ExperimentStatus {
  scheduled,
  inProgress,
  completed,
}
