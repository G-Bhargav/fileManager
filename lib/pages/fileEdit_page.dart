// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';

class FileEdit extends StatefulWidget {
  const FileEdit({super.key});

  @override
  State<FileEdit> createState() => _FileEditState();
}

class _FileEditState extends State<FileEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  Future<void> setText() async {
    final file = File("C:\\Users\\USER\\Desktop\\Home screen.txt");
    var body = file.readAsStringSync();
    var title = file.path.split(Platform.pathSeparator).last.split(".")[0];
    titleController.text = title;
    bodyController.text = body;
  }

  @override
  void initState() {
    super.initState();
    setText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context,'/home');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          minLines: 32,
          maxLines: 1000,
          controller: bodyController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Body",
          ),
        ),
      ),
    );
  }
}
