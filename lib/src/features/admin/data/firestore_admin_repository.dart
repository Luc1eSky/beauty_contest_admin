import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/firestore_constants.dart';
import '../../../firestore/firestore_instance_provider.dart';
import '../../authorize/domain/app_admin.dart';
import '../domain/firestore_admin_data.dart';

part 'firestore_admin_repository.g.dart';

class FirestoreAdminRepository {
  FirestoreAdminRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // get reference to admin doc and convert to custom class
  DocumentReference<FirestoreAdminData?> getAdminDocRef(AppAdmin admin) =>
      _firestore.collection(adminCollectionName).doc(admin.uid).withConverter(
            fromFirestore: (doc, _) =>
                doc.data() == null ? null : FirestoreAdminData.fromJson(doc.data()!),
            toFirestore: (FirestoreAdminData? adminData, options) =>
                adminData == null ? {} : adminData.toJson(),
          );

  // create new admin doc in firestore
  Future<void> createAdminDoc({required AppAdmin admin}) async {
    // admin document ref
    final adminDocRef = getAdminDocRef(admin);

    // check if document exists
    final adminDocSnap = await adminDocRef.get();

    // create admin doc if it doesnt exist already
    if (adminDocSnap.exists) {
      // TODO: LOGGING?
      print('ADMIN DOC ALREADY EXISTS!');
    } else {
      final adminData = FirestoreAdminData(isAnonymous: admin.isAnonymous, experimentDocIds: []);
      await adminDocRef.set(adminData);
    }
  }

  Future<void> addExperiment({required String experimentDocId, required AppAdmin admin}) async {
    // admin document ref
    final adminDocRef = getAdminDocRef(admin);

    await adminDocRef.update({
      experimentListName: FieldValue.arrayUnion([experimentDocId])
    });
  }

  /// stream the list of experiment document IDs for a specific admin
  Stream<List<String>?> watchExperimentDocIdList(AppAdmin? admin) {
    // return null if the current user (from auth) is null
    if (admin == null) {
      return Stream.value(null);
    }

    // get the admin document reference and stream
    final adminDocRef = getAdminDocRef(admin);
    final docSnapStream = adminDocRef.snapshots();
    // convert stream to a stream of a list of strings and return
    final stringListStream = docSnapStream.map((docSnap) => docSnap.data()?.experimentDocIds);
    return stringListStream;
  }
}

@Riverpod(keepAlive: true)
FirestoreAdminRepository firestoreAdminRepository(FirestoreAdminRepositoryRef ref) {
  return FirestoreAdminRepository(ref.watch(firestoreInstanceProvider));
}

@riverpod
Stream<List<String>?> experimentDocIdsStream(ExperimentDocIdsStreamRef ref, AppAdmin? admin) {
  final firestoreAdminRepository = ref.watch(firestoreAdminRepositoryProvider);
  return firestoreAdminRepository.watchExperimentDocIdList(admin);
}
