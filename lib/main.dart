import 'package:beauty_contest_admin/src/app.dart';
import 'package:beauty_contest_admin/src/constants/debug_constants.dart';
import 'package:beauty_contest_admin/src/exceptions/controller_observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

Future<void> setupEmulators() async {
  await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099); // host and port
  FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080); // host and port
  // add all other emulators here as well
}

/// needs to be async to use await
void main() async {
  // do this before anything else
  WidgetsFlutterBinding.ensureInitialized();
  // initialize with default options from firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // setup emulators after firebase was initialized but before the app runs
  if (useEmulators && kDebugMode) {
    await setupEmulators();
  }

  final container = ProviderContainer(observers: [ControllerObserver()]);

  // run the app
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
