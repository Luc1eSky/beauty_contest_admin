import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../localization/string_hardcoded.dart';
import '../../../../style/color_palette.dart';
import '../../../authorize/data/auth_repository.dart';
import '../new_experiment/new_experiment_dialog.dart';
import 'experiment_limit_reached_dialog.dart';
import 'experiment_list_view.dart';
import 'experiments_overview_screen_controller.dart';

/// screen that shows all experiments and allows to create new one
class ExperimentsOverviewScreen extends ConsumerWidget {
  const ExperimentsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowNewExperiment = ref.watch(canCreateNewExperimentProvider);

    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: const OverviewAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return allowNewExperiment
                        ? const NewExperimentDialog()
                        : const ExperimentLimitReachedDialog();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Create Experiment'.hardcoded,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          const Expanded(child: ExperimentListView()),
        ],
      ),
    );
  }
}

/// custom AppBar
class OverviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OverviewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//
// /// Floating Action Button that reacts differently based on limitations
// class NewExperimentButton extends StatelessWidget {
//   const NewExperimentButton({
//     super.key,
//     required this.allowNewExperiment,
//   });
//
//   final bool allowNewExperiment;
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {
//         showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) {
//             return allowNewExperiment
//                 ? const NewExperimentDialog()
//                 : const ExperimentLimitReachedDialog();
//           },
//         );
//       },
//       child: const Icon(Icons.add),
//     );
//   }
// }
