import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({Key? key}) : super(key: key);

  @override
  StudentFormScreenState createState() => StudentFormScreenState();
}

class StudentFormScreenState extends State<StudentFormScreen> {
  final _textController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  Future<void> _submitData() async {
    final enteredText = _textController.text.trim();
    final currentContext = context;

    if (enteredText.isEmpty) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Please enter some text')),
      );
      return;
    }

    try {
      await _firestore.collection('userInputs').add({
        'text': enteredText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _textController.clear();

      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(content: Text('Data saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(currentContext).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Any Text')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter any text'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('userInputs')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final entries = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      var entry = entries[index];
                      return ListTile(
                        title: Text(entry['text']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}