import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'student_form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentFormScreen(),
    );
  }
}