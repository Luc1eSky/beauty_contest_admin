import 'package:flutter/material.dart';

import '../../../../../src/localization/string_hardcoded.dart';

class SignInTitleWidget extends StatelessWidget {
  const SignInTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: FittedBox(
          child: Text(
            textAlign: TextAlign.end,
            'BEAUTY CONTEST'.hardcoded,
            style: const TextStyle(fontSize: 100),
          ),
        ),
      ),
    );
  }
}
