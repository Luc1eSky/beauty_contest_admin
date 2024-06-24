import 'package:beauty_contest_admin/src/constants/firestore_constants.dart';
import 'package:beauty_contest_admin/src/features/settings/domain/general_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firestore/firestore_instance_provider.dart';

part 'firestore_settings_repository.g.dart';

class FirestoreSettingsRepository {
  FirestoreSettingsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // /// read the current general settings from firestore
  // Future<GeneralSettings?> getGeneralSettings() async {
  //   final settingsDocRef = _firestore.collection(settingsCollectionName).doc(settingsDocName);
  //   final settingsDocSnap = await settingsDocRef.get();
  //   final docData = settingsDocSnap.data();
  //   final generalSettings = docData == null ? null : GeneralSettings.fromJson(docData);
  //   return generalSettings;
  // }

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
