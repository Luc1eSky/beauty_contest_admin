import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../style/color_palette.dart';
import '../../../authorize/data/auth_repository.dart';
import '../new_experiment/new_experiment_dialog.dart';
import 'experiment_list_view.dart';

class ExperimentsOverviewScreen extends StatelessWidget {
  const ExperimentsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const ExperimentListView(),
    );
  }
}
