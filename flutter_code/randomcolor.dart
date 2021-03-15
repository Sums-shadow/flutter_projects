// main.dart
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // This holds the items of the ListView
  final _listItems = List.generate(200, (i) => "Item $i");

  // Used to generate random integers
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kindacode.com'),
        ),
        body: ListView.builder(
          itemCount: _listItems.length,
          itemBuilder: (_, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                  [_random.nextInt(9) * 100],
              child: Container(
                padding: const EdgeInsets.all(30),
                child: Text(
                  _listItems[index],
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          },
        ));
  }
}

// By Kindacode.com