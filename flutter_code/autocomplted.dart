// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This will be displayed below the autocomplete field
  String _selectedAnimal;

  // This list holds all the suggestions 
  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindacode.com'),
      ),
      body: Column(
        children: [
          Container(
            child: Autocomplete(
              optionsBuilder: (TextEditingValue value) {
                // When the field is empty
                if (value.text.isEmpty) {
                  return [];
                }

                // The logic to find out which ones should appear
                return _suggestions.where((suggestion) => suggestion
                    .toLowerCase()
                    .contains(value.text.toLowerCase()));
              },
              onSelected: (value) {
                setState(() {
                  _selectedAnimal = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(_selectedAnimal != null
              ? _selectedAnimal
              : 'Type something (a, b, c, etc)'),
        ],
      ),
    );
  }
}