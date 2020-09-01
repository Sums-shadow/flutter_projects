import 'package:flutter/material.dart';
import 'package:sums/admin/addAdmin.dart';
import 'package:sums/admin/allProduct.dart';
import 'package:sums/admin/delAdm.dart';
import 'package:sums/admin/modAdmin.dart';

class Admin_Home extends StatefulWidget {
  @override
  _Admin_HomeState createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Tous les produits"),
            onTap: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=>new AllProduct()));
            },
          ),
          ListTile(
            title: Text("Ajouter un produit"),
            onTap: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=>new AddAdmin()));
            },
          ),
          ListTile(
            title: Text("Modifié un produits"),
            onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=>new ModAdmin()))
          ),
          ListTile(
            title: Text("Supprimer produits"),
            onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=>new DelAdm()))

          ),
        ],
      ),
    );
  }
}
