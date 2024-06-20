import 'package:beauty_contest_admin/src/features/experiments/presentation/experiment_in_progress_screen.dart';
import 'package:beauty_contest_admin/src/features/experiments/presentation/experiments_overview_screen_controller.dart';
import 'package:beauty_contest_admin/src/features/experiments/presentation/new_experiment_dialog.dart';
import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:beauty_contest_admin/src/style/color_palette.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authorize/data/auth_repository.dart';
import '../domain/experiment.dart';

class ExperimentsOverviewScreen extends ConsumerWidget {
  const ExperimentsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experimentQuery =
        ref.read(experimentsOverviewScreenControllerProvider.notifier).getExperimentQuery();
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: AppBar(
        flexibleSpace: Consumer(
          builder: (context, ref, child) {
            return Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(authRepositoryProvider).signOut();
                  },
                  child: const Text('Sign Out'),
                ),
                IconButton(
                  onPressed: () async {
                    final token = await ref.read(authRepositoryProvider).getIdToken();
                    print(token);
                  },
                  icon: const Icon(
                    Icons.ice_skating,
                  ),
                )
              ],
            );
          },
        ),
        title: Center(child: Text('Experiments'.hardcoded)),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          // width: 200,
          // height: 200,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const NewExperimentDialog();
                  });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
      body: experimentQuery == null
          ? Container(
              color: Colors.red,
              height: 500,
              width: 500,
            )
          : FirestoreListView(
              query: experimentQuery,
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
                            child: const Text('START'),
                          ),
                        ),
                      );
              },
            ),
    );
  }
}
