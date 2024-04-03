import 'package:flutter/material.dart';
import 'dart:io';
import 'home_page.dart';

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
    final args = ModalRoute.of(context)!.settings.arguments as DataClass?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
      ),
      body: Padding(
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
      floatingActionButton: TextButton(
        onPressed: () {
          final title = titleController.text;
          var proceed=true;
          for (var element in args!.files) {
            if(element.path.split(Platform.pathSeparator).last.split(".")[0]==title){
              proceed=false;
              break;
            }
          }
          if(title==""){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Blank Title is not allowed"))
            );
          }
          else if(!proceed){
            //warn about existence
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("File with same name is already present in the same directory!!!"))
            );
          }
          else{
            var file = File('${args.path}\\${titleController.text}.txt');
            file.writeAsString(bodyController.text);
            Navigator.pop(context);
          }

        },
        child: const Text("Save"),

      ),
    );
  }
}
