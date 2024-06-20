import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/firestore_constants.dart';
import '../../../firestore/firestore_instance_provider.dart';
import '../domain/app_admin.dart';

part 'firestore_admin_repository.g.dart';

class FirestoreAdminRepository {
  FirestoreAdminRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // create new admin doc in firestore
  Future<void> createAdminDoc({required AppAdmin admin}) async {
    // admin collection ref
    final adminCollectionRef = _firestore.collection(adminCollectionName);

    // check if document exists
    final adminDocSnap = await adminCollectionRef.doc(admin.uid).get();

    // create admin doc if it doesnt exist already
    if (adminDocSnap.exists) {
      // TODO: LOGGING?
      print('ADMIN DOC ALREADY EXISTS!');
    } else {
      await adminCollectionRef.doc(admin.uid).set({'isAnonymous': admin.isAnonymous});
    }
  }

  Future<void> addExperiment({required String experimentDocId, required AppAdmin admin}) async {
    final adminCollectionRef = _firestore.collection(adminCollectionName);
    await adminCollectionRef.doc(admin.uid).update({
      experimentListName: FieldValue.arrayUnion([experimentDocId])
    });
  }

  Future<List<String>> getExperimentDocIdList({required AppAdmin admin}) async {
    final adminCollectionRef = _firestore.collection(adminCollectionName);
    final adminDocRef = adminCollectionRef.doc(admin.uid);
    final adminDocSnap = await adminDocRef.get();

    // TODO: ERROR HANDLING
    if (!adminDocSnap.exists) {
      throw Exception('ERROR - adminDocSnap does not exist!');
    }

    final adminData = adminDocSnap.data();

    if (adminData == null || adminData.isEmpty) {
      throw Exception('ERROR!');
    }

    // get list of experiment doc IDs of current admin as list of strings
    final listOfExperimentDocIds =
        (adminData[experimentListName] as List<dynamic>).map((e) => e.toString()).toList();

    return listOfExperimentDocIds;
  }

  // deleteUser
}

@riverpod
FirestoreAdminRepository firestoreAdminRepository(FirestoreAdminRepositoryRef ref) {
  return FirestoreAdminRepository(ref.watch(firestoreInstanceProvider));
}
