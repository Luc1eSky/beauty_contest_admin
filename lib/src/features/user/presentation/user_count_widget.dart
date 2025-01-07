import 'package:beauty_contest_admin/src/features/user/data/user_submission_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../experiments/domain/experiment.dart';

class UserCountWidget extends ConsumerWidget {
  const UserCountWidget({super.key, required this.experiment});

  final Experiment experiment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCounts = ref.watch(userSubmissionCountStreamProvider(experiment.docId ?? ''));
    return userCounts.when(
      data: (data) => Text('PARTICIPANTS: ${data.submissions}/${data.total}'),
      error: (error, stack) => Container(color: Colors.red),
      loading: () => const SizedBox(),
    );
  }
}
