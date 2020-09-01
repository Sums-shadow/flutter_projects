import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sums/admin/modelAdmin.dart';
import 'package:image_picker/image_picker.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  String nom = "";
  File img;
  FirebaseStorage storage =FirebaseStorage(storageBucket: "gs://avenirbizdrc.appspot.com");
  StorageUploadTask task;
  String path = "images/${DateTime.now()}.png";
  String url = "";
  Firestore fs = Firestore.instance;
  StorageTaskSnapshot ts;

  void startUpload()async {
    
      task = storage.ref().child(path).putFile(img);
      print(task); 
      ts = await task.onComplete;
      url = await ts.ref.getDownloadURL();
       await fs
              .collection("product")
              .add({"nom": nom, "image": url}).then((value) {
            print(
                "insertion de ${nom} reussi avec $value et aussi ${value.toString()}");
          }).catchError((err) {
            print("erreur lors de l'insertion de ${nom} erreur $err");
          }).whenComplete(() => Navigator.of(context).pop());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MaterialButton(
        child: Text("Ajouter"),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (){
           startUpload();
        },
      ),
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Container(
        child: ListView(
          children: [
            Form(
                child: Column(
              children: [
                TextField(
                  onChanged: (val) {
                    setState(() {
                      nom = val;
                    });
                  },
                ),
                Container(
                  child: img != null ? Image.file(img) : Placeholder(),
                ),
                Text(img == null ? 'No image selected' : img.toString()),
                MaterialButton(
                  child: Text("Ajouter une photo"),
                  onPressed: () {
                    getImage();
                  },
                  color: Colors.green,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      img = image;
    });
  }
}

 