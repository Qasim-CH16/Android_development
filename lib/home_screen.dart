import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'add_record_screen.dart';
import 'subject.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Subject> _subjects = [];

  Future<void> _loadSubjects() async {
    final subjects = await DBHelper.getSubjects();
    setState(() {
      _subjects = subjects;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  void _navigateToAddScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddRecordScreen(
          onSubjectAdded: _loadSubjects,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text("Menu")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddScreen,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Image.asset('assets/car.png', height: 200),
          Expanded(
            child: ListView.builder(
              itemCount: _subjects.length,
              itemBuilder: (context, index) {
                final subject = _subjects[index];
                return ListTile(
                  title: Text(subject.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teacher: ${subject.teacher}'),
                      Text('Credits: ${subject.credits}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}