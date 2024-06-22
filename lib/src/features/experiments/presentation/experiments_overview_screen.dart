import 'package:beauty_contest_admin/src/features/experiments/data/firestore_experiment_repository.dart';
import 'package:beauty_contest_admin/src/features/experiments/presentation/new_experiment_dialog.dart';
import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:beauty_contest_admin/src/style/color_palette.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../admin/data/firestore_admin_repository.dart';
import '../../authorize/data/auth_repository.dart';
import '../domain/experiment.dart';
import 'experiment_in_progress_screen.dart';

class ExperimentsOverviewScreen extends ConsumerWidget {
  const ExperimentsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAdmin = ref.watch(authRepositoryProvider).getCurrentUser();
    final listOfExperimentsValue = ref.watch(experimentDocIdsStreamProvider(currentAdmin));
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
      body: listOfExperimentsValue.when(
        data: (listOfExperiments) {
          if (listOfExperiments == null) {
            return Container(color: Colors.orange);
          }

          print(listOfExperiments);

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
                          child: const Text('START'),
                        ),
                      ),
                    );
            },
          );

          //   Container(
          //   color: Colors.yellow,
          //   child: Center(
          //     child: Text(listOfExperiments.toString()),
          //   ),
          // );
        },
        error: (e, st) => Container(
          color: Colors.red,
          child: const Center(child: Text('Could not find admin doc.')),
        ),
        loading: () => Container(color: Colors.purpleAccent),
      ),

      // StreamBuilder(
      //   stream: experimentStream,
      //   builder: (BuildContext context, AsyncSnapshot<Object?> snapshot) {
      //     print(snapshot.data);
      //     return Container();
      //   },
      // ),

      // : FirestoreListView(
      //     query: experimentQuery,
      //     itemBuilder: (context, snapshot) {
      //       Experiment? experiment = snapshot.data();
      //
      //       return experiment == null
      //           ? const SizedBox()
      //           : Card(
      //               child: ListTile(
      //                 title: Text(experiment.name),
      //                 subtitle: Text(experiment.createdOn.toString()),
      //                 trailing: ElevatedButton(
      //                   onPressed: () {
      //                     Navigator.of(context).push(
      //                       MaterialPageRoute(
      //                         builder: (context) {
      //                           return ExperimentInProgressScreen(
      //                             experiment: experiment,
      //                           );
      //                         },
      //                       ),
      //                     );
      //                   },
      //                   child: const Text('START'),
      //                 ),
      //               ),
      //             );
      //     },
      //   ),
    );
  }
}
