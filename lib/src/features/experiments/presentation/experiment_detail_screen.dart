import 'package:flutter/material.dart';

import '../../../style/color_palette.dart';

class ExperimentDetailScreen extends StatelessWidget {
  const ExperimentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        title: const Center(child: Text('Experiment Details')),
      ),
      body: Container(),
    );
  }
}
