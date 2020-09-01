import 'package:flutter/material.dart';


class Home_Localisation extends StatefulWidget {
  @override
  _Home_LocalisationState createState() => _Home_LocalisationState();
}

class _Home_LocalisationState extends State<Home_Localisation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localisation"),
        centerTitle: true,
      ),
      body: ListView
        (
        children: <Widget>[
          ListTile(
            title: Text("Se geolocaliser"),
          ),
        ],
      ),
    );
  }
}
