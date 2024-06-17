import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_instance_provider.g.dart';

@riverpod
FirebaseFirestore firestoreInstance(FirestoreInstanceRef ref) {
  return FirebaseFirestore.instance;
}
