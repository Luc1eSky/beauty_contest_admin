import 'package:freezed_annotation/freezed_annotation.dart';

part 'experiment.freezed.dart';
part 'experiment.g.dart';

@freezed
class Experiment with _$Experiment {
  const factory Experiment({
    required String adminUid,
    required String name,
    required String location,
    required ExperimentStatus status,
    required DateTime createdOn,
    String? docId,
  }) = _Experiment;
  factory Experiment.fromJson(Map<String, dynamic> json) => _$ExperimentFromJson(json);

  factory Experiment.fromFirestore(Map<String, dynamic> json, String docId) {
    final experiment = Experiment.fromJson(json);
    final experimentWithId = experiment.copyWith(docId: docId);
    return experimentWithId;
  }
}

enum ExperimentStatus {
  scheduled,
  inProgress,
  completed,
}
