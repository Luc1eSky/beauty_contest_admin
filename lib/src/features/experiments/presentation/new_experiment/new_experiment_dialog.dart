import 'package:beauty_contest_admin/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'new_experiment_dialog_controller.dart';

final _formKey = GlobalKey<FormState>();

class NewExperimentDialog extends ConsumerStatefulWidget {
  const NewExperimentDialog({super.key});

  @override
  ConsumerState<NewExperimentDialog> createState() => _NewExperimentDialogState();
}

class _NewExperimentDialogState extends ConsumerState<NewExperimentDialog> {
  final nameController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(newExperimentDialogControllerProvider);

    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text('Add New Experiment'.hardcoded),
          content: Form(
            key: _formKey,
            child: SizedBox(
              width: 500, // max width
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    maxLength: 50,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter experiment name'.hardcoded;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'e.g. LSE Conference Fall 2024 - 1'.hardcoded,
                      labelText: 'Experiment Name'.hardcoded,
                      //icon: Icon(Icons.person),
                    ),
                  ),
                  TextFormField(
                    controller: locationController,
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location'.hardcoded;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'e.g. USFCA'.hardcoded,
                      labelText: 'Experiment Location'.hardcoded,
                      //icon: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: asyncState.isLoading
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              child: Text('CANCEL'.hardcoded),
            ),
            ElevatedButton(
              onPressed: asyncState.isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(newExperimentDialogControllerProvider.notifier)
                            .createExperiment(
                              name: nameController.text,
                              location: locationController.text,
                            );
                      }
                    },
              child: Text('OK'.hardcoded),
            ),
          ],
        ),
      ),
    );
  }
}
