import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'experiments_overview_screen_controller.g.dart';

@riverpod
class ExperimentsOverviewScreenController extends _$ExperimentsOverviewScreenController {
  @override
  Future<void> build() async {
    // nothing to do
  }

  // Stream<List<String>?>? getExperimentStream() {
  //   try {
  //     final currentAdmin = ref.read(authRepositoryProvider).getCurrentUser();
  //     if (currentAdmin == null) {
  //       return null;
  //     }
  //     return ref
  //         .watch(firestoreAdminRepositoryProvider)
  //         .watchExperimentDocIdList(admin: currentAdmin);
  //   } catch (e, st) {
  //     print(e);
  //     print(st);
  //   }
  // }

  // Query<Experiment?>? getExperimentQuery() {
  //   try {
  //     final currentAdmin = ref.read(authRepositoryProvider).getCurrentUser();
  //     if (currentAdmin == null) {
  //       return null;
  //     }
  //
  //     // get list of experiment doc ids for admin
  //     final experimentDocIdList =
  //         ref.read(firestoreAdminRepositoryProvider).getExperimentDocIdList(admin: currentAdmin);
  //
  //     final experimentsQuery =
  //         ref.read(firestoreExperimentRepositoryProvider).getExperimentQuery(experimentDocIdList);
  //     return experimentsQuery;
  //   } catch (error, stack) {
  //     state = AsyncError(error, stack);
  //   }
  //   return null;
  // }
}
