import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/app_constants.dart';
import '../../../firestore/firestore_instance_provider.dart';

part 'user_submission_repository.g.dart';

class UserSubmissionRepository {
  UserSubmissionRepository(this._firestore);
  final FirebaseFirestore _firestore;

  /// get count of currently joined users int total and count of submissions
  Stream<({int submissions, int total})> getUserSubmissionCountStream(String experimentDocId) {
    // get user collections reference of specific experiment
    final usersCollectionRef = _firestore
        .collection(experimentsCollectionName)
        .doc(experimentDocId)
        .collection(usersCollectionName);
    // create collection stream
    final usersCollectionRefStream = usersCollectionRef.snapshots();
    // calculate count numbers from each collection snapshot
    return usersCollectionRefStream.map((snapshot) {
      final userJoinedCount = snapshot.docs.length;
      final userSubmissionCount =
          snapshot.docs.where((snap) => snap.data().containsKey('submittedOn')).length;
      return (submissions: userSubmissionCount, total: userJoinedCount);
    });
  }
}

@Riverpod(keepAlive: true)
UserSubmissionRepository userSubmissionRepository(UserSubmissionRepositoryRef ref) {
  return UserSubmissionRepository(ref.watch(firestoreInstanceProvider));
}

@riverpod
Stream<({int submissions, int total})> userSubmissionCountStream(
    UserSubmissionCountStreamRef ref, String experimentDocId) {
  final userSubmissionRepository = ref.watch(userSubmissionRepositoryProvider);
  return userSubmissionRepository.getUserSubmissionCountStream(experimentDocId);
}
