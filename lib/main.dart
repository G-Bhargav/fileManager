// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_manager/pages/fileEdit_page.dart';
import 'package:file_manager/pages/home_page.dart';
import 'package:file_manager/pages/newFile_page.dart';
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
        '/fileEdit' : (context) => FileEdit(),
        '/home': (context) => Home(),
        '/new': (context) => NewFile(),
      },
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}