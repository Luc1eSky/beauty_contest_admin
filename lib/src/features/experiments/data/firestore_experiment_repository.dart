import 'package:beauty_contest_admin/src/constants/firestore_constants.dart';
import 'package:beauty_contest_admin/src/firestore/firestore_instance_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/experiment.dart';

part 'firestore_experiment_repository.g.dart';

class FirestoreExperimentRepository {
  FirestoreExperimentRepository(this._firestore);
  final FirebaseFirestore _firestore;

  /// create a new experiment document in firestore
  Future<String> createExperimentDoc({required Experiment experiment}) async {
    final experimentCollectionRef = _firestore.collection(experimentsCollectionName);
    final docRef = await experimentCollectionRef.add(experiment.toJson());
    return docRef.id;
  }

  void deleteExperimentDoc() {
    print('deleting doc');
  }

  /// create query for specific experiment doc ids
  Query<Experiment?> getExperimentQuery(List<String> experimentIds) {
    final experimentCollectionRef = _firestore.collection(experimentsCollectionName);
    return experimentCollectionRef
        .where(FieldPath.documentId, whereIn: experimentIds)
        .orderBy('createdOn', descending: true)
        .withConverter<Experiment?>(
          fromFirestore: (snapshot, _) =>
              snapshot.data() == null ? null : Experiment.fromJson(snapshot.data()!),
          toFirestore: (experiment, _) => experiment == null ? {} : experiment.toJson(),
        );
  }

  void startExperiment({required Experiment experiment}) {}
}

@riverpod
FirestoreExperimentRepository firestoreExperimentRepository(FirestoreExperimentRepositoryRef ref) {
  return FirestoreExperimentRepository(ref.watch(firestoreInstanceProvider));
}
