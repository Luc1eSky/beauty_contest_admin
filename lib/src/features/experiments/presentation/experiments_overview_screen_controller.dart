import 'package:beauty_contest_admin/src/features/authorize/data/auth_repository.dart';
import 'package:beauty_contest_admin/src/features/experiments/data/firestore_experiment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/experiment.dart';

part 'experiments_overview_screen_controller.g.dart';

@riverpod
class ExperimentsOverviewScreenController extends _$ExperimentsOverviewScreenController {
  @override
  Future<void> build() async {
    // nothing to do
  }

  Query<Experiment?>? getExperimentQuery() {
    try {
      final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
      if (currentUser == null) {
        return null;
      }
      final experimentsQuery =
          ref.read(firestoreExperimentRepositoryProvider).getExperimentQuery(currentUser);
      return experimentsQuery;
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
    return null;
  }
}
