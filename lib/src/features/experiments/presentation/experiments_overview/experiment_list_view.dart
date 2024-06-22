import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../admin/data/firestore_admin_repository.dart';
import '../../../authorize/data/auth_repository.dart';
import '../../data/firestore_experiment_repository.dart';
import '../../domain/experiment.dart';
import '../experiment_in_progress/experiment_in_progress_screen.dart';

class ExperimentListView extends ConsumerWidget {
  const ExperimentListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAdmin = ref.watch(authRepositoryProvider).getCurrentUser();
    final listOfExperimentsValue = ref.watch(experimentDocIdsStreamProvider(currentAdmin));

    return listOfExperimentsValue.when(
      error: (e, st) => Container(
        color: Colors.red,
        child: const Center(child: Text('Could not find admin doc.')),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (listOfExperiments) {
        // show nothing if there is no list or list is empty
        if (listOfExperiments == null || listOfExperiments.isEmpty) {
          return const SizedBox();
        }

        final query =
            ref.read(firestoreExperimentRepositoryProvider).getExperimentQuery(listOfExperiments);

        return FirestoreListView(
          query: query,
          itemBuilder: (context, snapshot) {
            Experiment? experiment = snapshot.data();

            return experiment == null
                ? const SizedBox()
                : Card(
                    child: ListTile(
                      title: Text(experiment.name),
                      subtitle: Text(experiment.createdOn.toString()),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ExperimentInProgressScreen(
                                  experiment: experiment,
                                );
                              },
                            ),
                          );
                        },
                        child: Text('START'.hardcoded),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
