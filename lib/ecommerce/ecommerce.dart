import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Ecommerce extends StatefulWidget {
  @override
  _EcommerceState createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
  var doc = Firestore.instance;
  QuerySnapshot data;
  StorageReference refs;

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
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (ctx) =>
                              new Detail(data.documents[i]["nom"])));
                    },
                    child: Card(
                        child: Column(
                      children: [
                        // Image.network(data.documents[i]["image"], ),
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: data.documents[i]["image"],
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
                          child: Text(data.documents[i]["nom"]),
                        ),
                      ],
                    )),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class Detail extends StatefulWidget {
  String nom;
  Detail(this.nom);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.nom),
    );
  }
}
