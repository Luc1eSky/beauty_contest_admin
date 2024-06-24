import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../authorize/data/auth_repository.dart';
import '../../data/firestore_experiment_repository.dart';
import '../../domain/experiment.dart';

part 'experiments_list_view_controller.g.dart';

@riverpod
class ExperimentsListViewController extends _$ExperimentsListViewController {
  @override
  Future<void> build() async {
    // nothing to do
  }

  Query<Experiment?> getExperimentQuery() {
    final currentAdmin = ref.watch(authRepositoryProvider).getCurrentUser();
    return ref.read(firestoreExperimentRepositoryProvider).getExperimentQuery(currentAdmin);
  }
}
