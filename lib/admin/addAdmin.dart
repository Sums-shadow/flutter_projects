import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sums/admin/modelAdmin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sums/model/produit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddAdmin extends StatefulWidget {
  @override
  _AddAdminState createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  TextEditingController nom=TextEditingController();
  TextEditingController prix=TextEditingController();
  TextEditingController desc=TextEditingController();
  File img;
  FirebaseStorage storage =FirebaseStorage(storageBucket: "gs://avenirbizdrc.appspot.com");
  StorageUploadTask task;
  String path = "images/${DateTime.now()}.png";
  String url = "";
  Firestore fs = Firestore.instance;
  StorageTaskSnapshot ts;
  Produit prod;
  bool isSend=false;
  void startUpload()async {
    setState(()=>isSend=true);
    
      task = storage.ref().child(path).putFile(img);
      print(task); 
      ts = await task.onComplete;
      url = await ts.ref.getDownloadURL();
    prod=new Produit(null, nom.text, prix.text, url);
       await fs
              .collection("product")
              .add(prod.toMap()).then((value) {
                 setState(()=>isSend=false);
            print(
                "insertion de ${nom.text} reussi avec $value et aussi ${value.toString()}");
                
          }).catchError((err) {
            print("erreur lors de l'insertion de ${nom} erreur $err");
          }).whenComplete(() => Navigator.of(context).pop());
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MaterialButton(
        child:isSend?CircularProgressIndicator(): Text("Ajouter"),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                   Container(
                    child: img != null ? Image.file(img) : Placeholder(),
                  ),
                  Text(img == null ? 'No image selected' : img.toString()),
                  TextField(
                     controller: nom,
                     decoration: InputDecoration(
                       hintText: "Nom du produit",
                       
                     ),
                  ),
                   TextField(
                     controller: prix,
                     decoration: InputDecoration(
                       hintText: "Prix du produit",
                       
                     ),
                  ),
                  
                 
                  MaterialButton(
                    child: Text("Ajouter une photo"),
                    onPressed: () {
                      getImage();
                    },
                    color: Colors.green,
                  )
                ],
              )),
            )
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

 