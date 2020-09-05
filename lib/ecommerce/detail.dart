import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sums/database/db.dart';
import 'package:sums/model/produit.dart';

class Detail extends StatefulWidget {
  String image, nom, prix;
  Detail(this.image, this.nom, this.prix);

  @override
  _DetailState createState() => _DetailState();
}
 
class _DetailState extends State<Detail> {
  TextEditingController count = TextEditingController();
  DB db = new DB();
  SharedPreferences preferences;

  init() async {
    preferences = await SharedPreferences.getInstance();
    count.text = "0";
    print(widget.nom);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detailuit")),
      bottomNavigationBar: Builder(
        builder: (context) => MaterialButton(
          onPressed: () {
            CProduit cp = new CProduit( widget.nom, widget.prix,
                preferences.getString("uid"), count.text);
            db.insertCProduit(cp).then((value) {
              print("insertion reussi $value");
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Ajouter au panier"),
                duration: Duration(milliseconds: 3000),
              ));
            }).catchError((err) => print("error on insertion $err"));
          },
          child: Text("Ajouter au panier"),
          color: Colors.red,
          textColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: CachedNetworkImage(
                imageUrl: widget.image.toString(),
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
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Nom: ${widget.nom.toString()}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Prix: ${widget.prix.toString()}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.minimize), onPressed: () => crement("-")),
                Container(
                  width: 30,
                  child: TextField(
                    controller: count,
                    onChanged: (val) {
                      if (val == '') {
                        count.text = "0";
                      }
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add), onPressed: () => crement("+")),
              ],
            )
          ],
        ),
      ),
    );
  }

  crement(String n) {
    if (n == "+") {
      setState(() => count.text = (int.parse(count.text) + 1).toString());
    } else {
      setState(() => count.text == '0'
          ? '0'
          : count.text = (int.parse(count.text) - 1).toString());
    }
  }
}
