import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/firestore_constants.dart';
import '../../../firestore/firestore_instance_provider.dart';
import '../../authorize/domain/app_admin.dart';

part 'firestore_admin_repository.g.dart';

class FirestoreAdminRepository {
  FirestoreAdminRepository(this._firestore);
  final FirebaseFirestore _firestore;

  //DocumentReference<FirestoreAdminData?>
  DocumentReference getAdminDocRef(AppAdmin admin) =>
      _firestore.collection(adminCollectionName).doc(admin.uid);

  // .withConverter(
  //   fromFirestore: (doc, _) =>
  //       doc.data() == null ? null : FirestoreAdminData.fromJson(doc.data()!),
  //   toFirestore: (FirestoreAdminData? adminData, options) =>
  //       adminData == null ? {} : adminData.toJson(),
  // );

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
      //final adminData = FirestoreAdminData(isAnonymous: admin.isAnonymous, experimentDocIds: []);
      await adminDocRef.set({'isAnonymous': admin.isAnonymous});
    }
  }

  Future<void> addExperiment({required String experimentDocId, required AppAdmin admin}) async {
    // admin document ref
    final adminDocRef = getAdminDocRef(admin);

    await adminDocRef.update({
      experimentListName: FieldValue.arrayUnion([experimentDocId])
    });
  }

  Stream<List<String>?> watchExperimentDocIdList(AppAdmin? admin) {
    if (admin == null) {
      return Stream.value(null);
    }

    final adminDocRef = getAdminDocRef(admin);
    final docSnapStream = adminDocRef.snapshots();
    //final stringListStream = docSnapStream.map((docSnap) => docSnap.data()?.experimentDocIds);

    final mapStream = docSnapStream.map((snapshot) => snapshot.data() as Map<String, dynamic>?);

    final dynamicListStream =
        mapStream.map((mapEntry) => mapEntry?[experimentListName] as List<dynamic>?);

    final stringListStream = dynamicListStream.map((dynamicList) =>
        dynamicList?.map((dynamicListEntry) => dynamicListEntry.toString()).toList());

    return stringListStream;
  }

  // deleteUser
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
