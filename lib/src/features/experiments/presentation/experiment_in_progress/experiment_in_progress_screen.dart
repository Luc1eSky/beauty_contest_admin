import 'package:flutter/material.dart';

import '../../../../style/color_palette.dart';
import '../../domain/experiment.dart';

class ExperimentInProgressScreen extends StatelessWidget {
  const ExperimentInProgressScreen({super.key, required this.experiment});
  final Experiment experiment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        title: Center(child: Text('Experiment: ${experiment.name}')),
      ),
      body: Container(height: 500, width: 500),
    );
  }
}
