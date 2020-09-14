 

import 'package:flutter/material.dart';
import 'package:sums/ecommerce/allCommande.dart';
import 'package:sums/ecommerce/commande.dart';
import 'package:sums/ecommerce/ecommerce.dart';

class HomeEcommerce extends StatefulWidget {
  @override
  _HomeEcommerceState createState() => _HomeEcommerceState();
}

class _HomeEcommerceState extends State<HomeEcommerce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ecommerce Home"),
      ),
      body: GridView(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          InkWell(
            onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=>Ecommerce())),
            child: Card(
              child: Center(
                child: Text("Ecommerce"),
              ),
            ),
          ),
          InkWell(
            onTap:()=>Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=>CommandeEcommerce())),
            child: Card(
              child: Center(
                child: Text("Commandes"),
              ),
            ),
          ),
           InkWell(
            onTap:()=>Navigator.of(context).push(new MaterialPageRoute(builder: (ctx)=>AllCommande())),
            child: Card(
              child: Center(
                child: Text("All Commandes"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
