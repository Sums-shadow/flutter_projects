import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sums/model/produit.dart';

class DelAdm extends StatefulWidget {
  @override
  _DelAdmState createState() => _DelAdmState();
}

class _DelAdmState extends State<DelAdm> {
  QuerySnapshot data;
  FirebaseStorage fb = FirebaseStorage.instance;
  Firestore fs = Firestore.instance;
  bool clicked = false;
  Produit prod;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    fs.collection("product").getDocuments().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Product"),
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.documents.length,
              itemBuilder: (context, i) {
                prod = new Produit(null, data.documents[i]["nom"],
                    data.documents[i]["prix"], data.documents[i]["image"]);
                return ListTile(
                  title: Text(prod.nom.toString()),
                  subtitle: Text("\$${prod.prix.toString()}"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(prod.image.toString()),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return clicked
                                  ? AlertDialog(
                                      content: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : AlertDialog(
                                      content: Text(
                                          "Voulez-vous vraiment suprimer ${data.documents[i]['nom']}?"),
                                      actions: [
                                        RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              clicked = true;
                                            });
                                            fs
                                                .collection("product")
                                                .document(data
                                                    .documents[i].documentID)
                                                .delete()
                                                .then((value) {
                                              print("supression reussie");
                                              getData();
                                              setState(() {
                                                clicked = false;
                                              });
                                            }).whenComplete(() =>
                                                    Navigator.of(context)
                                                        .pop());
                                          },
                                          child: Text("Oui"),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Non"),
                                        )
                                      ],
                                    );
                            });
                      }),
                );
              }),
    );
  }
}
