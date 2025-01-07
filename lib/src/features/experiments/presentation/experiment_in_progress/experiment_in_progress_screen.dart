import 'package:beauty_contest_admin/src/features/result/presentation/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../style/color_palette.dart';
import '../../../user/presentation/user_count_widget.dart';
import '../../data/firestore_experiment_repository.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SizedBox(
            width: 800,
            child: AspectRatio(
              aspectRatio: 0.7,
              child: Hero(
                tag: experiment.docId!,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: FittedBox(
                            child: Text(
                              'PLEASE SCAN TO PARTICIPATE:',
                              style: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 14,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: QrImageView(
                                data: 'https://beauty-contest-participant.web'
                                    '.app/login/${experiment.docId}',
                                version: QrVersions.auto,
                                //backgroundColor: Colors.grey,
                                //size: 200.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FittedBox(
                            child: Text(
                              '.../login/${experiment.docId}',
                              style: const TextStyle(
                                fontSize: 100,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 1,
                          child: UserCountWidget(experiment: experiment),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Consumer(
                              builder: (context, ref, child) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    // close experiment by setting status to "completed"
                                    await ref
                                        .read(firestoreExperimentRepositoryProvider)
                                        .closeExperiment(experiment: experiment);
                                    // move to result screen
                                    if (context.mounted) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const ResultScreen(),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('CLOSE EXPERIMENT'),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
