import 'package:beauty_contest_admin/src/features/admin/data/firestore_admin_repository.dart';
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
      final currentAdmin = ref.read(authRepositoryProvider).getCurrentUser();
      if (currentAdmin == null) {
        return null;
      }

      // get list of experiment doc ids for admin
      final experimentDocIdList =
          ref.read(firestoreAdminRepositoryProvider).getExperimentDocIdList(admin: currentAdmin);

      final experimentsQuery =
          ref.read(firestoreExperimentRepositoryProvider).getExperimentQuery(experimentDocIdList);
      return experimentsQuery;
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }
    return null;
  }
}
