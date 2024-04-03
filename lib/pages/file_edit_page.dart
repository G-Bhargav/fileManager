import 'dart:io';
import 'package:flutter/material.dart';
import 'home_page.dart';

class FileEdit extends StatefulWidget {
  const FileEdit({super.key});

  @override
  State<FileEdit> createState() => _FileEditState();
}

class _FileEditState extends State<FileEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  late String parent;
  var initialTitle = "";

  Future<void> setText(String path) async {
    final file = File(path);
    var body = file.readAsStringSync();
    initialTitle = file.path.split(Platform.pathSeparator).last.split(".")[0];
    parent = file.parent.path;
    titleController.text = initialTitle;
    bodyController.text = body;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataClass?;
    setText((args != null) ? args.path : "");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Title",
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              File(args!.path).delete();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              minLines: 32,
              maxLines: 1000,
              controller: bodyController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Body",
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          final title = titleController.text;
          if (initialTitle != title) {
            var file = File('$parent\\${titleController.text}.txt');
            file.writeAsString(bodyController.text);
            File(args!.path).delete();
            Navigator.pop(context);
          } else {
            var proceed = true;
            for (var element in args!.files) {
              if (element.path
                      .split(Platform.pathSeparator)
                      .last
                      .split(".")[0] ==
                  title) {
                proceed = false;
                break;
              }
            }
            if (title == "") {
              //Alert
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Blank Title is not allowed"),
                ),
              );
            } else if (!proceed) {
              //warn about existence
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "File with same name is already present in the same directory!!!"),
                ),
              );
            } else {
              var file = File('$parent\\${titleController.text}.txt');
              file.writeAsString(bodyController.text);
              Navigator.pop(context);
            }
          }
        },
        child: const Text("Save"),
      ),
    );
  }
}
