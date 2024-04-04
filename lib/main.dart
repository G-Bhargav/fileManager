import 'package:file_manager/pages/file_edit_page.dart';
import 'package:file_manager/pages/home_page.dart';
import 'package:file_manager/pages/new_file_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/fileEdit' : (context) => const FileEdit(),
        '/home': (context) => const Home(),
        '/new': (context) => const NewFile(),
      },
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}