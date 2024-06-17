import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_widget.dart';
import 'sign_in_responsive_layout.dart';
import 'sign_in_title_widget.dart';

/// First screen that user sees. Allows to continue as guest
/// or login or signup (both via email and password)
class LoginScreen extends ConsumerWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SignInResponsiveLayout(
      designWidget: Container(color: Colors.purpleAccent),
      titleWidget: const SignInTitleWidget(),
      loginWidget: const LoginWidget(),
    );
  }
}
