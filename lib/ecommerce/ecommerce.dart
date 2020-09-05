import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sums/model/produit.dart';

import 'detail.dart';

class Ecommerce extends StatefulWidget {
  @override
  _EcommerceState createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
  var doc = Firestore.instance;
  QuerySnapshot data;
  StorageReference refs;
Produit prod;
  @override
  void initState() {
    super.initState();
    doc.collection("product").getDocuments().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
                

    return Scaffold(
        appBar: AppBar(
          title: Text("Ecommerce"),
        ),
        body: data != null
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: data.documents.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                   prod=new Produit(null,data.documents[i]["nom"],data.documents[i]["prix"],data.documents[i]["image"]);
                  return data.documents.length!=0? InkWell(
                    onTap: () {
                     
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (ctx) =>
                              new Detail(data.documents[i]["image"],data.documents[i]["nom"],data.documents[i]["prix"])));
                    },
                    child: Card(
                        child: Column(
                      children: [
                        // Image.network(data.documents[i]["image"], ),
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: prod.image.toString(),
                            placeholder: (context, url) => Expanded(
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  width: 48.0,
                                  height: 78.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Center(
                          child: Text(prod.nom.toString()),
                        ),
                        Center(
                          child: Text(prod.prix.toString()),
                        ),
                      ],
                    )),
                  ):Center(child: Text("No items found"),);
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
 