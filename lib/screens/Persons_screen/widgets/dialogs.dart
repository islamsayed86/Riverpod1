import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_1/screens/Persons_screen/person_repo.dart';
import 'package:riverpod_1/screens/Persons_screen/persons_change_notifier_provider.dart';

Future<Person?> createOrUpdatePersonDialog(BuildContext context, WidgetRef ref,
    [Person? existingPerson]) {
  final peopleWatcher = ref.watch(peopleProvider);
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;
  peopleWatcher.nameController.text = name ?? '';
  peopleWatcher.ageController.text = age?.toString() ?? '';
  return showDialog<Person?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Creat A Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: peopleWatcher.nameController,
                decoration: const InputDecoration(labelText: 'Enter Name Here'),
                onChanged: (value) => name = value,
              ),
              TextField(
                controller: peopleWatcher.ageController,
                decoration: const InputDecoration(labelText: 'Enter Age Here'),
                onChanged: (value) => age = int.tryParse(value),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (name != null && age != null) {
                  if (existingPerson != null) {
                    // have existing person
                    final newPerson = existingPerson.updated(
                      name,
                      age,
                    );
                    Navigator.of(
                      context,
                    ).pop(newPerson);
                  } else {
                    // no existing person, create a new one
                    Navigator.of(
                      context,
                    ).pop(
                      Person(name: name!, age: age!),
                    );
                  }
                } else {
                  // no name,no age or both
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      });
}
