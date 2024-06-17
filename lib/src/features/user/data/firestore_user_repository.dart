import 'package:beauty_contest_admin/src/features/user/domain/app_user.dart';
import 'package:beauty_contest_admin/src/firestore/firestore_instance_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/firestore_constants.dart';

part 'firestore_user_repository.g.dart';

class FirestoreUserRepository {
  FirestoreUserRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // create new user doc in firestore
  Future<void> createUserDoc({required AppUser user}) async {
    // users collection ref
    final userCollectionRef = _firestore.collection(userCollectionName);

    //check if document exists
    final userDocSnap = await userCollectionRef.doc(user.uid).get();

    // create user doc if it doesnt exist already
    if (userDocSnap.exists) {
      // TODO: LOGGING?
      print('USER DOC ALREADY EXISTS!');
    } else {
      await userCollectionRef.doc(user.uid).set({'isAnonymous': user.isAnonymous});
    }
  }

  // deleteUser
}

@riverpod
FirestoreUserRepository firestoreUserRepository(FirestoreUserRepositoryRef ref) {
  return FirestoreUserRepository(ref.watch(firestoreInstanceProvider));
}
