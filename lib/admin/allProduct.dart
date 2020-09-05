import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sums/model/produit.dart';


class AllProduct extends StatefulWidget {
  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  QuerySnapshot data;
  Firestore fs=Firestore.instance;
    Produit prod;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("storage ${storage.ref().child("image").getData(10000)}");
    fs.collection("product").getDocuments().then((value) {
      setState(() {
       data=value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All products"),
      ),
      body:data!=null
          ?ListView.builder(
            physics: BouncingScrollPhysics(),
             
          itemCount: data.documents.length,
          itemBuilder: (ctx, i){
      //       List imgs=[];
      //       FirebaseStorage storage =
      // FirebaseStorage(storageBucket: "gs://avenirbizdrc.appspot.com");
      //   storage.ref().child(data.documents[i]["image"]).getDownloadURL().then((value) {
      //   print(value);
      //   imgs.add(value);

      // });
      // print(imgs[0]);
      prod=new Produit(null,data.documents[i]["nom"],data.documents[i]["prix"],data.documents[i]["image"]);
            return ListTile(
              title: Text(prod.nom.toString()),
              subtitle: Text(prod.prix.toString()),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(prod.image.toString()),
              ),
            );
      })
      :Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
}
