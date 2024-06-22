// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// import '../../../admin/data/firestore_admin_repository.dart';
// import '../../../authorize/data/auth_repository.dart';
//
// part 'experiments_list_view_controller.g.dart';
//
// @riverpod
// class ExperimentsListViewController extends _$ExperimentsListViewController {
//   @override
//   Future<void> build() async {
//     // nothing to do
//   }
//
//   AsyncValue<List<String>?> getExperimentListStream() {
//     //try {
//     final currentAdmin = ref.watch(authRepositoryProvider).getCurrentUser();
//     final listOfExperimentsValue = ref.watch(experimentDocIdsStreamProvider(currentAdmin));
//     return listOfExperimentsValue;
//     // } catch (error, stack) {
//     //   state = AsyncError(error, stack);
//     //   return null;
//     // }
//   }
//
//   // Stream<List<String>?>? getExperimentStream() {
//   //   try {
//   //     final currentAdmin = ref.read(authRepositoryProvider).getCurrentUser();
//   //     if (currentAdmin == null) {
//   //       return null;
//   //     }
//   //     return ref
//   //         .watch(firestoreAdminRepositoryProvider)
//   //         .watchExperimentDocIdList(admin: currentAdmin);
//   //   } catch (e, st) {
//   //     print(e);
//   //     print(st);
//   //   }
//   // }
//
//   // Query<Experiment?>? getExperimentQuery() {
//   //   try {
//   //     final currentAdmin = ref.read(authRepositoryProvider).getCurrentUser();
//   //     if (currentAdmin == null) {
//   //       return null;
//   //     }
//   //
//   //     // get list of experiment doc ids for admin
//   //     final experimentDocIdList =
//   //         ref.read(firestoreAdminRepositoryProvider).getExperimentDocIdList(admin: currentAdmin);
//   //
//   //     final experimentsQuery =
//   //         ref.read(firestoreExperimentRepositoryProvider).getExperimentQuery(experimentDocIdList);
//   //     return experimentsQuery;
//   //   } catch (error, stack) {
//   //     state = AsyncError(error, stack);
//   //   }
//   //   return null;
//   // }
// }
