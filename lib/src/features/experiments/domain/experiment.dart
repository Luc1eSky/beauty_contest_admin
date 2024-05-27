import 'package:freezed_annotation/freezed_annotation.dart';

part 'experiment.freezed.dart';
part 'experiment.g.dart';

@freezed
class Experiment with _$Experiment {
  const factory Experiment({
    required String name,
    required String location,
    required ExperimentStatus status,
  }) = _Experiment;
  factory Experiment.fromJson(Map<String, dynamic> json) => _$ExperimentFromJson(json);
}

// class Experiment {
//   const Experiment({
//     required this.name,
//     required this.location,
//     required this.status,
//   });
//
//   final String name;
//   final String location;
//   final ExperimentStatus status;
// }

enum ExperimentStatus {
  scheduled,
  inProgress,
  completed,
}
