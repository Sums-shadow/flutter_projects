import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sums/model/produit.dart';

class ModAdmin extends StatefulWidget {
  @override
  _ModAdminState createState() => _ModAdminState();
}

class _ModAdminState extends State<ModAdmin> {
  Firestore fs = Firestore.instance;
  QuerySnapshot data;
  FirebaseStorage ref = FirebaseStorage.instance;
  StorageUploadTask task;
  String path = "images/${DateTime.now()}.png";
  String url = "";
  StorageTaskSnapshot ts;
  File img;
  bool updateClick = false;
  TextEditingController nom = TextEditingController();
  TextEditingController prix = TextEditingController();
bool click=false;
  Produit prod;
  Produit prodsi;
  @override
  void initState() {
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
        title: Text("Modifier"),
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : buildBody(),
    );
  }

  Future dial(context, i) {
    return showDialog(
        context: context,
        builder: (ctx) {
          nom.text = data.documents[i]['nom'];
          return AlertDialog(
            content: ListView(
              children: [
                img == null
                    ? Image.network(data.documents[i]["image"])
                    : Image.file(img),
                RaisedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: Text("Modifier la photo"),
                ),
                TextField(
                  controller: nom,
                ),
                TextField(
                  controller: prix,
                ),
                FlatButton(
                    onPressed: () async {
                      setState(()=>click=true);

                      if (img != null) {
                        updateClick = true;
                        task = ref.ref().child(path).putFile(img);
                        ts = await task.onComplete;
                        url = await ts.ref.getDownloadURL();
                        prod = new Produit(null, nom.text, prix.text, url);
                        prodsi =
                            new Produit.sansImage(null, nom.text, prix.text);
                      }
                      try {
                        url == ""
                            ? await fs
                                .collection("product")
                                .document(data.documents[i].documentID)
                                .updateData({
                                'nom': nom.text,
                                'prix': prix.text,
                              }).then((value) {
                                updateClick = false;

                                print("update successful");
                      setState(()=>click=false);

                              }).whenComplete(() => Navigator.of(context).pop())
                            : await fs
                                .collection("product")
                                .document(data.documents[i].documentID)
                                .updateData(prod.toMap())
                                .then((value) {
                                updateClick = false;
                                getData();

                                print("update successful");
                              }).whenComplete(
                                    () => Navigator.of(context).pop());
                      } catch (e) {
                        print("error on update  $e");
                      setState(()=>click=false);

                      }
// updateClick?CircularProgressIndicator():
                    },
                    child:click? CircularProgressIndicator(): Text("Valider la modification"))
              ],
            ),
          );
        });
  }

  Widget buildBody() {
    return ListView.builder(
        itemCount: data.documents.length,
        itemBuilder: (context, i) {
          Produit p = new Produit(null, data.documents[i]["nom"],
              data.documents[i]["prix"], data.documents[i]["image"]);
          return ListTile(
            title: Text(p.nom.toString()),
            subtitle: Text("\$${p.prix.toString()}"),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(p.image.toString()),
            ),
            trailing: IconButton(
                icon: Icon(Icons.edit), onPressed: () => dial(context, i)),
          );
        });
  }

  getImage() {
    setState(() async {
      img = await ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
}
