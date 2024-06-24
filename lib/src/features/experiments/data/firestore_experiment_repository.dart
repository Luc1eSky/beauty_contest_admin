import 'package:beauty_contest_admin/src/constants/firestore_constants.dart';
import 'package:beauty_contest_admin/src/features/authorize/domain/app_admin.dart';
import 'package:beauty_contest_admin/src/firestore/firestore_instance_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/experiment.dart';

part 'firestore_experiment_repository.g.dart';

class FirestoreExperimentRepository {
  FirestoreExperimentRepository(this._firestore);
  final FirebaseFirestore _firestore;

  /// create a new experiment document in firestore
  Future<void> createExperimentDoc({required Experiment experiment}) async {
    final experimentCollectionRef = _firestore.collection(experimentsCollectionName);
    await experimentCollectionRef.add(experiment.toJson());
  }

  /// delete a specific experiment document in firestore
  Future<void> deleteExperimentDoc({required String documentId}) async {
    final experimentDocRef = _firestore.collection(experimentsCollectionName).doc(documentId);
    await experimentDocRef.delete();
  }

  /// create query for all experiments of a specific admin
  Query<Experiment?> getExperimentQuery(AppAdmin? admin) {
    final experimentCollectionRef = _firestore.collection(experimentsCollectionName);
    return experimentCollectionRef
        .where('adminUid', isEqualTo: admin?.uid ?? 'no admin')
        .orderBy('createdOn', descending: true)
        .withConverter<Experiment?>(
          fromFirestore: (snapshot, _) => snapshot.data() == null
              ? null
              : Experiment.fromFirestore(snapshot.data()!, snapshot.id),
          toFirestore: (experiment, _) => experiment == null ? {} : experiment.toJson(),
        );
  }

  /// starting a specific experiment
  void startExperiment({required Experiment experiment}) {}
}

@riverpod
FirestoreExperimentRepository firestoreExperimentRepository(FirestoreExperimentRepositoryRef ref) {
  return FirestoreExperimentRepository(ref.watch(firestoreInstanceProvider));
}
