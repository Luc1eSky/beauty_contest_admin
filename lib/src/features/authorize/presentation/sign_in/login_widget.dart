import 'package:beauty_contest_admin/src/features/authorize/presentation/sign_in/login_screen_controller.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWidget extends ConsumerWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SignInScreen(
      providers: [EmailAuthProvider()],
      headerMaxExtent: 100,
      headerBuilder: (context, constraints, shrinkOffset) {
        final loginGuestState = ref.watch(loginScreenControllerProvider);

        return Center(
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[800],
              backgroundColor: Colors.grey[400],
              overlayColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: loginGuestState.isLoading
                ? null
                : () async {
                    await ref.read(loginScreenControllerProvider.notifier).signInGuest();
                  },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Guest Sign In',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      },
    );
  }
}
