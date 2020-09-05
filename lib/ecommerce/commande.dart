import 'package:flutter/material.dart';
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
  bool hasProd = true;
  init() async {
    commande = await db.fetchCprod();
    setState(() {
      prod = commande;
      hasProd = prod.length > 0;
      print(hasProd);
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
            await db.deleteAllCProd().then((value) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Votre commande a été effectué, patienter la confirmation")));
            });
            init();
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
      body: prod!=null? (
        prod.length > 0
          ? ListView.builder(
              itemCount: commande.length,
              itemBuilder: (c, i) {
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
            )):CircularProgressIndicator()
    );
  }
}
