import 'package:beauty_contest_admin/src/constants/firestore_constants.dart';
import 'package:beauty_contest_admin/src/firestore/firestore_instance_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../user/domain/app_user.dart';
import '../domain/experiment.dart';

part 'firestore_experiment_repository.g.dart';

class FirestoreExperimentRepository {
  FirestoreExperimentRepository(this._firestore);
  final FirebaseFirestore _firestore;

  /// create a new experiment document in firestore
  Future<void> createExperimentDoc({required Experiment experiment, required AppUser? user}) async {
    if (user == null) {
      throw Exception('No user signed in.');
    }
    final userCollectionRef = _firestore.collection(userCollectionName);
    final userDocRef = userCollectionRef.doc(user.uid);
    final experimentCollectionRef = userDocRef.collection(experimentsCollectionName);
    await experimentCollectionRef.add(experiment.toJson());
  }

  void deleteExperimentDoc() {
    print('deleting doc');
  }

  Query<Experiment?> getExperimentQuery(AppUser user) {
    final userCollectionRef = _firestore.collection(userCollectionName);
    final userDocRef = userCollectionRef.doc(user.uid);
    final experimentCollectionRef = userDocRef.collection(experimentsCollectionName);
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
}

@riverpod
FirestoreExperimentRepository firestoreExperimentRepository(FirestoreExperimentRepositoryRef ref) {
  return FirestoreExperimentRepository(ref.watch(firestoreInstanceProvider));
}
