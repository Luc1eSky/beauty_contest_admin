import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../localization/string_hardcoded.dart';

// TODO: FINISH SIGNUP FLOW AND DESIGN

/// a dialog that pops up when the "plus" button is pressed
/// but no additional experiments can be created
/// should lead user that is currently a guest to sign up for free
class ExperimentLimitReachedDialog extends StatelessWidget {
  const ExperimentLimitReachedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text('Limit reached'.hardcoded),
          content: const SizedBox(
            width: dialogMaxWidth,
            child: Text('hello bla bla bla --> sign up'),
          ),
          actions: [
            ElevatedButton(
              onPressed: //asyncState.isLoading? null:
                  () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL'.hardcoded),
            ),
          ],
        ),
      ),
    );
  }
}
