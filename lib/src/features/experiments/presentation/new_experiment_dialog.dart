import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class NewExperimentDialog extends StatefulWidget {
  const NewExperimentDialog({super.key});

  @override
  State<NewExperimentDialog> createState() => _NewExperimentDialogState();
}

class _NewExperimentDialogState extends State<NewExperimentDialog> {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  bool buttonsAreActive = true;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: const Text('Add New Experiment'),
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
                        return 'Please enter experiment name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'e.g. LSE Conference Fall 2024 - 1',
                      labelText: 'Experiment Name',
                      //icon: Icon(Icons.person),
                    ),
                  ),
                  TextFormField(
                    controller: locationController,
                    maxLength: 30,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'e.g. USFCA',
                      labelText: 'Experiment Location',
                      //icon: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: !buttonsAreActive
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: !buttonsAreActive
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        print('VALID DATA!');
                        setState(() => buttonsAreActive = false);
                        final experimentName = nameController.text;
                        final experimentLocation = locationController.text;
                        print('TRY TO CREATE EXPERIMENT...');
                        try {
                          await createExperiment();
                        } catch (error, stack) {
                          print(error);
                          print(stack);
                          setState(() => buttonsAreActive = true);
                        }
                      }
                    },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> createExperiment() async {
  // TODO: REPLACE WITH FIRESTORE
  await Future.delayed(const Duration(milliseconds: 1000));
  throw Exception('Something went wrong');
}
