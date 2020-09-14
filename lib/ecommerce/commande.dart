import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sums/database/db.dart';
import 'package:sums/model/produit.dart';

class CommandeEcommerce extends StatefulWidget {
  @override
  _CommandeEcommerceState createState() => _CommandeEcommerceState();
}

class _CommandeEcommerceState extends State<CommandeEcommerce> {
  final DB db = DB();
  var commande;
  List<CProduit> prod;
  Firestore fs = Firestore.instance;
  var produit = [];
  bool hasProd = true;
  SharedPreferences preferences;
  init() async {
    preferences = await SharedPreferences.getInstance();
    commande = await db.fetchCprod();
    setState(() {
      prod = commande;

      prod.forEach((element) {
        print(element.nom);
        produit.add({"nom": element.nom, "prix": element.prix});
      });

      hasProd = prod.length > 0;
    });
  }

  delete(var i) async {
    await db.deleteCProd(i);
    init();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              print(commande);

              prod != null
                  ? (prod.length > 0
                      ? fs.document(preferences.getString("uid")).collection("commandes").add({
                          "uid": preferences.getString("uid"),
                          "commande": produit,
                          "lu": "non"
                        }).then((value) async {
                          await db.deleteAllCProd().then((value) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Votre commande a été effectué, patienter la confirmation")));
                          });
                          init();
                        }).catchError((err) {
                          print(err);
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Une erreur est survenue lors de la commande $err ${err.toString()}")));
                        })
                      : Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Aucune commande trouvée"))))
                  : Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Aucune commande trouvée")));
            },
            child: Icon(
              Icons.shopping_basket,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
          );
        }),
        appBar: AppBar(
          title: Text("Commande"),
        ),
        body: prod != null
            ? (prod.length > 0
                ? ListView.builder(
                    itemCount: commande.length,
                    itemBuilder: (c, i) {
                      prod.map((e) => print("val $e"));
                      return Card(
                        child: ListTile(
                          title: Text(commande[i].nom),
                          subtitle: Text('\$${commande[i].prix}'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              delete(commande[i].nom);
                            },
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text("No Product Found"),
                  ))
            : CircularProgressIndicator());
  }
}
