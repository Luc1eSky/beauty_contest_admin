import 'package:beauty_contest_admin/src/features/experiments/data/firestore_experiment_repository.dart';
import 'package:beauty_contest_admin/src/features/result/presentation/result_screen.dart';
import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_constants.dart';
import '../../domain/experiment.dart';
import '../experiment_in_progress/experiment_in_progress_screen.dart';
import 'experiments_list_view_controller.dart';

class ExperimentListView extends ConsumerWidget {
  const ExperimentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.read(experimentsListViewControllerProvider.notifier).getExperimentQuery();
    return FirestoreListView(
      query: query,
      //loadingBuilder: (context) => const Center(child: CircularProgressIndicator()),
      //errorBuilder: (context, stack, error) => Center(child: Text(error.toString())),
      itemBuilder: (context, snapshot) {
        Experiment? experiment = snapshot.data();
        return experiment == null
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: cardsMaxWidth,
                  child: Hero(
                    tag: experiment.docId!,
                    child: Card(
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${experiment.name}'),
                              Text('Location: ${experiment.location}'),
                            ],
                          ),
                          subtitle: Text(experiment.createdOn.toString()),
                          trailing: switch (experiment.status) {
                            ExperimentStatus.scheduled => StartButton(experiment: experiment),
                            ExperimentStatus.inProgress => ResumeButton(experiment: experiment),
                            ExperimentStatus.completed => ShowSummaryButton(experiment: experiment),
                          }),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class StartButton extends ConsumerWidget {
  const StartButton({
    super.key,
    required this.experiment,
  });

  final Experiment experiment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        // navigate to ExperimentInProgressScreen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExperimentInProgressScreen(experiment: experiment),
          ),
        );
        // start experiment and set status to "inProgress"
        await ref
            .read(firestoreExperimentRepositoryProvider)
            .startExperiment(experiment: experiment);
      },
      child: Text('START'.hardcoded),
    );
  }
}

class ResumeButton extends StatelessWidget {
  const ResumeButton({
    super.key,
    required this.experiment,
  });

  final Experiment experiment;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExperimentInProgressScreen(experiment: experiment),
          ),
        );
      },
      child: Text('RESUME'.hardcoded),
    );
  }
}

class ShowSummaryButton extends StatelessWidget {
  const ShowSummaryButton({
    super.key,
    required this.experiment,
  });

  final Experiment experiment;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ResultScreen(),
          ),
        );
      },
      child: Text('SHOW SUMMARY'.hardcoded),
    );
  }
}
