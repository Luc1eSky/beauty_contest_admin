import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_constants.dart';
import '../../../../localization/string_hardcoded.dart';
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
      itemBuilder: (context, snapshot) {
        Experiment? experiment = snapshot.data();
        return experiment == null
            ? const SizedBox()
            : Center(
                child: SizedBox(
                  width: cardsMaxWidth,
                  child: Card(
                    child: ListTile(
                      title: Text('Name: ${experiment.name}, location: ${experiment.location}, '
                          'ID: ${experiment.docId}'),
                      subtitle: Text(experiment.createdOn.toString()),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExperimentInProgressScreen(experiment: experiment),
                            ),
                          );
                        },
                        child: Text('START'.hardcoded),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
