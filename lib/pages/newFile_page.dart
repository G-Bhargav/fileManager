// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NewFile extends StatefulWidget {
  const NewFile({super.key});

  @override
  State<NewFile> createState() => _NewFileState();
}

class _NewFileState extends State<NewFile> {

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

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
      floatingActionButton: TextButton(
        onPressed: () { },
        child: Text("Save"),

      ),
    );
  }
}
