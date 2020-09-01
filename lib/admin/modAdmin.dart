import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          :buildBody() ,
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
                FlatButton(
                    onPressed: () async {
                      if (img != null) {
                        updateClick = true;
                        task = ref.ref().child(path).putFile(img);
                        ts = await task.onComplete;
                        url = await ts.ref.getDownloadURL();
                      }
                      try {
                        url == ""
                            ? await fs
                                .collection("product")
                                .document(data.documents[i].documentID)
                                .updateData({"nom": nom.text}).then((value) {
                                updateClick = false;

                                print("update successful");
                              }).whenComplete(() => Navigator.of(context).pop())
                            : await fs
                                .collection("product")
                                .document(data.documents[i].documentID)
                                .updateData({
                                "nom": nom.text,
                                "image": url
                              }).then((value) {
                                updateClick = false;
                                getData();
                                
                                print("update successful");
                              }).whenComplete(
                                    () => Navigator.of(context).pop());
                      } catch (e) {
                        print("error on update");
                      }
// updateClick?CircularProgressIndicator():
                    },
                    child: Text("Valider la modification"))
              ],
            ),
          );
        });
  }

  Widget buildBody(){
    return ListView.builder(
              itemCount: data.documents.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(data.documents[i]['nom']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data.documents[i]["image"]),
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => dial(context, i)),
                );
              });
  }

  getImage() {
    setState(() async {
      img = await ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }
}
