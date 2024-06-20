import 'package:beauty_contest_admin/src/constants/firestore_constants.dart';
import 'package:beauty_contest_admin/src/firestore/firestore_instance_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../admin/domain/app_admin.dart';
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

  Query<Experiment?> getExperimentQuery(List<String> experimentIds) {
    print('HERE');

    //create query for specific experiment doc ids

    final experimentCollectionRef = adminDocRef.collection(experimentsCollectionName);
    return experimentCollectionRef
        .orderBy('createdOn', descending: true)
        .withConverter<Experiment?>(
          fromFirestore: (snapshot, _) {
            // if any conversion error occurs, return null
            try {
              return Experiment.fromJson(snapshot.data()!);
            } catch (error) {
              // TODO: ADD LOGGING
              return null;
            }
          },
          // converter only used to get query, not to write
          toFirestore: (experiment, _) => experiment!.toJson(),
        );
  }

  void startExperiment({required Experiment experiment}) {}
}

@riverpod
FirestoreExperimentRepository firestoreExperimentRepository(FirestoreExperimentRepositoryRef ref) {
  return FirestoreExperimentRepository(ref.watch(firestoreInstanceProvider));
}
