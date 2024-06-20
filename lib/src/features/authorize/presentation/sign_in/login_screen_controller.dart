import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../admin/data/firestore_admin_repository.dart';
import '../../data/auth_repository.dart';

part 'login_screen_controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {
  @override
  Future<void> build() async {
    // nothing to do
  }

  /// sign in guest and create user doc in FB
  Future<void> signInGuest() async {
    // set async state to loading
    state = const AsyncValue.loading();
    // try to sign in and create user doc
    try {
      await ref.read(authRepositoryProvider).signInAnonymously();
      final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
      if (currentUser != null) {
        ref.read(firestoreAdminRepositoryProvider).createAdminDoc(admin: currentUser);
      }
      state = const AsyncValue.data(null);
    } catch (error, stack) {
      // set state to AsyncError
      state = AsyncError(error, stack);
    }
  }
}
