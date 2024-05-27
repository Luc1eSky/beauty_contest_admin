import 'package:beauty_contest_admin/src/style/color_palette.dart';
import 'package:flutter/material.dart';

import 'new_experiment_dialog.dart';

class ExperimentsOverviewScreen extends StatelessWidget {
  const ExperimentsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        title: const Center(child: Text('Experiments')),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return ExperimentDetailScreen();
              // }));

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const NewExperimentDialog();
                },
              );
            },
            child: const FittedBox(
              child: Icon(
                Icons.add,
                size: 150,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
