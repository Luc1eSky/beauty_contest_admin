import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_admin_data.freezed.dart';
part 'firestore_admin_data.g.dart';

/// makes interaction with admin doc in firestore easier
@freezed
class FirestoreAdminData with _$FirestoreAdminData {
  const factory FirestoreAdminData({
    required bool isAnonymous,
    required List<String> experimentDocIds,
  }) = _FirestoreAdminData;

  factory FirestoreAdminData.fromJson(Map<String, Object?> json) =>
      _$FirestoreAdminDataFromJson(json);
}
