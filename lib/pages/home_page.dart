// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class DataClass {
  String path = "";
  List<FileSystemEntity> files = [];
  DataClass(this.path,{this.files = const []});
}

class _HomeState extends State<Home> {
  List<FileSystemEntity> files = [];

  Future<bool> getList(String path) async {
    if (path != "") {
      files = Directory(path).listSync();
    }
    else{
      final directory = await getDownloadsDirectory();
      files = directory!.listSync();
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataClass?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("File Manager")
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: getList((args!=null) ? args.path : "" ),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: files.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  if(files[index].toString().contains("Directory")){
                      Navigator.pushNamed(context, '/home',arguments: DataClass(files[index].path));
                  }
                  else if(files[index].toString().contains(".txt")){
                    Navigator.pushNamed(context, '/fileEdit',arguments: DataClass(files[index].path));
                  }

                },
                child: Card(
                  color: Colors.lightBlueAccent,
                  child: SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(files[index]
                              .path
                              .split(Platform.pathSeparator)
                              .last
                              //.split(".").first
                          ),
                        ),
                        Icon(
                            (files[index].toString().contains("Directory"))
                            ? Icons.file_copy_sharp
                            : Icons.insert_drive_file_sharp
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Text("edo teda kottindi");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new',arguments: DataClass(args!.path,files: files));
        },
        tooltip: 'New File',
        child: const Icon(Icons.add),
      ),
    );
  }
}