import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class DataClass {
  String path = "";
  List<FileSystemEntity> files = [];
  DataClass(this.path, {this.files = const []});
}

class _HomeState extends State<Home> {
  List<FileSystemEntity> files = [];

  Future<String> downloadDirectory() async {
    final directory = await getDownloadsDirectory();
    return directory!.path;
  }

  Future<bool> getList(String path) async {
    if (path != "") {
      files = Directory(path).listSync();
    } else {
      final directory = await getDownloadsDirectory();
      files = directory!.listSync();
    }
    return true;
  }

  String customIcon(String ext) {
    const imageExt = ["png", "jpeg", "jpg", "heif"];
    const videoExt = ["mkv", "mov", "mp4"];
    const musicExt = ["mp3"];
    ext = ext.split("'").first;
    if (imageExt.contains(ext)) {
      return 'assets/icons/ic_fluent_image_24_regular.svg';
    } else if (videoExt.contains(ext)) {
      return 'assets/icons/ic_fluent_video_24_regular.svg';
    } else if (ext == "pdf") {
      return 'assets/icons/ic_fluent_document_pdf_24_regular.svg';
    } else if (musicExt.contains(ext)) {
      return 'assets/icons/ic_fluent_music_note_2_24_regular.svg';
    } else if (ext == "zip") {
      return 'assets/icons/ic_fluent_folder_zip_24_regular.svg';
    } else if (ext == "txt") {
      return 'assets/icons/ic_fluent_document_text_24_regular.svg';
    } else {
      return 'assets/icons/ic_fluent_text_box_24_regular.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataClass?;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 42, 54, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(98, 114, 164, 1),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("File Manager"),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder(
        future: getList((args != null) ? args.path : ""),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: files.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  if (files[index].toString().contains("Directory")) {
                    Navigator.pushNamed(context, '/home',
                        arguments: DataClass(files[index].path));
                  } else if (files[index].toString().contains(".txt")) {
                    Navigator.pushNamed(context, '/fileEdit',
                        arguments: DataClass(files[index].path));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Currently opening of this file is not supported"),
                          duration: Durations.long4,
                        ));
                  }
                },
                onSecondaryTap: () {
                  final file =
                      files[index].path.split(Platform.pathSeparator).last;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(file),
                    duration: Durations.long4,
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.75,
                          heightFactor: 0.75,
                          child: SvgPicture.asset(
                            (files[index].toString().contains("Directory"))
                                ? "assets/icons/ic_fluent_folder_24_regular.svg"
                                : customIcon(files[index]
                                    .toString()
                                    .split(Platform.pathSeparator)
                                    .last
                                    .split(".")
                                    .last),
                            color: const Color.fromRGBO(248, 248, 242, 0.75),
                            height: 100,
                          ),
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        files[index].path.split(Platform.pathSeparator).last,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromRGBO(248, 248, 242, 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String path = "";
          if (args == null) {
            path = await downloadDirectory();
          }
          Navigator.pushNamed(
            context,
            '/new',
            arguments: (args != null)
                ? DataClass(args.path, files: files)
                : DataClass(path, files: files),
          );
        },
        tooltip: 'New File',
        child: const Icon(Icons.add),
      ),
    );
  }
}
