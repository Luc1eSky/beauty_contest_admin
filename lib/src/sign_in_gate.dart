import 'package:beauty_contest_admin/src/features/authorize/data/firestore_auth_instance_provider.dart';
import 'package:beauty_contest_admin/src/style/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/experiments/presentation/experiments_overview_screen.dart';

/// sign in user anonymously and then show first screen or error screen
class SignInGate extends ConsumerWidget {
  const SignInGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthInstanceProvider);

    return FutureBuilder(
      future: firebaseAuth.signInAnonymously(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? const ExperimentsOverviewScreen()
            : snapshot.hasError
                ? const ErrorScreen()
                : const LoadingScreen();
      },
    );
  }
}

/// simple error screen that is shown when user cannot be signed in
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: show error message
    return Container(color: Colors.red);
  }
}

/// loading screen shown while signing in user anonymously
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette.background,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
