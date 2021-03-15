import 'package:flutter/material.dart';
import 'package:catex/catex.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kindacode.com'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: DefaultTextStyle(
              style: TextStyle(fontSize: 35, color: Colors.purple),
              child: Column(
                children: [
                  CaTeX(r'x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}'),
                  SizedBox(height: 35,),
                  CaTeX(r'\epsilon = \frac 2 {3 + 2}')
                ],
              )),
        ));
  }
}