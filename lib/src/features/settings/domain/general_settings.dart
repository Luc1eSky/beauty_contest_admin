import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_settings.freezed.dart';
part 'general_settings.g.dart';

/// makes interaction with settings doc in firestore easier
@freezed
class GeneralSettings with _$GeneralSettings {
  const factory GeneralSettings({
    required int freeExperimentCount,
  }) = _GeneralSettings;

  factory GeneralSettings.fromJson(Map<String, Object?> json) => _$GeneralSettingsFromJson(json);
}
