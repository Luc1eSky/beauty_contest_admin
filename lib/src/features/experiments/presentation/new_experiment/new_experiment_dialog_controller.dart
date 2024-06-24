import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../navigation/navigation_service.dart';
import '../../../admin/data/firestore_admin_repository.dart';
import '../../../authorize/data/auth_repository.dart';
import '../../data/firestore_experiment_repository.dart';
import '../../domain/experiment.dart';

part 'new_experiment_dialog_controller.g.dart';

@riverpod
class NewExperimentDialogController extends _$NewExperimentDialogController {
  @override
  Future<void> build() async {
    // nothing to do
  }

  Future<void> createExperiment({
    required String name,
    required String location,
  }) async {
    // set state to loading
    state = const AsyncValue.loading();

    // try to create experiment in database
    try {
      final admin = ref.read(authRepositoryProvider).getCurrentUser();

      if (admin == null) {
        throw Exception('Admin is not logged in');
      }
      // create experiment object
      final newExperiment = Experiment(
        name: name,
        location: location,
        status: ExperimentStatus.scheduled,
        createdOn: DateTime.now(),
        adminUid: admin.uid,
      );

      // create experiment in experiment collection
      await ref
          .read(firestoreExperimentRepositoryProvider)
          .createExperimentDoc(experiment: newExperiment);

      // increase experiment count in admin doc
      await ref.read(firestoreAdminRepositoryProvider).increaseExperimentCount(admin: admin);

      // close the new experiment dialog
      final context = NavigationService.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (error, stack) {
      // set state to AsyncError
      state = AsyncError(error, stack);
    }
  }
}
