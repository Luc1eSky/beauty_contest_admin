import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../admin/data/firestore_admin_repository.dart';
import '../../../authorize/data/auth_repository.dart';
import '../../../settings/data/firestore_settings_repository.dart';

part 'experiments_overview_screen_controller.g.dart';

@riverpod
bool canCreateNewExperiment(CanCreateNewExperimentRef ref) {
  final admin = ref.read(authRepositoryProvider).getCurrentUser();
  final adminData = ref.watch(firestoreAdminStreamProvider(admin));

  final generalSettings = ref.watch(firestoreSettingsStreamProvider);

  final adminDataValue = adminData.value;
  final generalSettingsValue = generalSettings.value;

  if (adminDataValue == null || generalSettingsValue == null) {
    return false;
  } else if (adminDataValue.isAnonymous &&
          adminDataValue.experimentCount < generalSettingsValue.freeExperimentCount ||
      adminDataValue.isAnonymous == false) {
    return true;
  }
  return false;
}
