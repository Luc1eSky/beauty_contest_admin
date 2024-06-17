import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:beauty_contest_admin/src/navigation/navigation_service.dart';
import 'package:beauty_contest_admin/src/sign_in_gate.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty Contest Admin App'.hardcoded,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInGate(),
    );
  }
}
