import 'package:beauty_contest_admin/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

/// needs to be async to use await
void main() async {
  // do this before anything else
  WidgetsFlutterBinding.ensureInitialized();
  // initialize with default options from firebase_options.dart
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // run the app
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
