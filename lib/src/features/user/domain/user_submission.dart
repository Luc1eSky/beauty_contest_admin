import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_submission.freezed.dart';
part 'user_submission.g.dart';

@freezed
class UserSubmission with _$UserSubmission {
  const factory UserSubmission({
    required DateTime joinedOn,
    required int number,
    required DateTime submittedOn,
    String? userUid,
  }) = _UserSubmission;

  factory UserSubmission.fromJson(Map<String, dynamic> json) => _$UserSubmissionFromJson(json);

  factory UserSubmission.fromFirestore(Map<String, dynamic> json, String docId) {
    final userSubmission = UserSubmission.fromJson(json);
    final userSubmissionWithId = userSubmission.copyWith(userUid: docId);
    return userSubmissionWithId;
  }
}
