// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 10,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.pushNamed(context,'/fileEdit');
          },
          child: Card(
            color: Colors.lightBlueAccent,
            child: SizedBox(
              child: Row(
                children: [
                  Text("File: $index"),
                  Icon(Icons.delete),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.popAndPushNamed(context, '/new');
        },
        tooltip: 'New File',
        child: const Icon(Icons.add),
      ),
    );
  }
}
