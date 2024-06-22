import 'package:beauty_contest_admin/src/features/authorize/data/auth_repository.dart';
import 'package:beauty_contest_admin/src/features/authorize/presentation/sign_in/login_screen.dart';
import 'package:beauty_contest_admin/src/features/experiments/presentation/experiments_overview/experiments_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// sign in user anonymously and then show first screen or error screen
class SignInGate extends ConsumerWidget {
  const SignInGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(authRepositoryProvider).authStateChanges();

    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // TODO: ERROR SCREEN
          return Container(color: Colors.red);
        }
        if (!snapshot.hasData) {
          return const LoginScreen();
        }
        return const ExperimentsOverviewScreen();
      },
    );
  }
}
