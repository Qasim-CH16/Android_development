import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'subject.dart';

class AddRecordScreen extends StatefulWidget {
  final Function() onSubjectAdded;

  const AddRecordScreen({super.key, required this.onSubjectAdded});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final _nameController = TextEditingController();
  final _teacherController = TextEditingController();
  final _creditsController = TextEditingController();

  void _saveSubject() async {
    final name = _nameController.text.trim();
    final teacher = _teacherController.text.trim();
    final credits = int.tryParse(_creditsController.text.trim()) ?? 0;

    if (name.isEmpty || teacher.isEmpty) return;

    final subject = Subject(
      name: name,
      teacher: teacher,
      credits: credits,
    );

    await DBHelper.insertSubject(subject);
    _nameController.clear();
    _teacherController.clear();
    _creditsController.clear();

    widget.onSubjectAdded();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Subject')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Subject Name'),
            ),
            TextField(
              controller: _teacherController,
              decoration: const InputDecoration(labelText: 'Teacher Name'),
            ),
            TextField(
              controller: _creditsController,
              decoration: const InputDecoration(labelText: 'Credits'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSubject,
              child: const Text('Save Subject'),
            )
          ],
        ),
      ),
    );
  }
}