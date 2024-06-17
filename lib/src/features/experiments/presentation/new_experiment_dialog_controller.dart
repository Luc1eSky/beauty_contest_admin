import 'package:beauty_contest_admin/src/navigation/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../authorize/data/auth_repository.dart';
import '../data/firestore_experiment_repository.dart';
import '../domain/experiment.dart';

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
      // create experiment object
      final newExperiment = Experiment(
        name: name,
        location: location,
        status: ExperimentStatus.scheduled,
        createdOn: DateTime.now(),
      );
      await ref.read(firestoreExperimentRepositoryProvider).createExperimentDoc(
            experiment: newExperiment,
            user: ref.watch(authRepositoryProvider).getCurrentUser(),
          );
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
