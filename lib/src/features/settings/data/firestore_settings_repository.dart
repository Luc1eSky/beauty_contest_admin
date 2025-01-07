import 'package:beauty_contest_admin/src/features/settings/domain/general_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firestore/firestore_instance_provider.dart';

part 'firestore_settings_repository.g.dart';

const String settingsCollectionName = 'settings';
const String settingsDocName = 'generalSettings';

class FirestoreSettingsRepository {
  FirestoreSettingsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<GeneralSettings?> watchGeneralSettings() {
    final settingsDocRef = _firestore.collection(settingsCollectionName).doc(settingsDocName);
    final docSnapStream = settingsDocRef.snapshots();
    final settingsStream = docSnapStream.map(
        (snapshot) => snapshot.data() == null ? null : GeneralSettings.fromJson(snapshot.data()!));
    return settingsStream;
  }
}

@Riverpod(keepAlive: true)
FirestoreSettingsRepository firestoreSettingsRepository(FirestoreSettingsRepositoryRef ref) {
  return FirestoreSettingsRepository(ref.watch(firestoreInstanceProvider));
}

@riverpod
Stream<GeneralSettings?> firestoreSettingsStream(FirestoreSettingsStreamRef ref) {
  final firestoreSettingsRepository = ref.watch(firestoreSettingsRepositoryProvider);
  return firestoreSettingsRepository.watchGeneralSettings();
}
