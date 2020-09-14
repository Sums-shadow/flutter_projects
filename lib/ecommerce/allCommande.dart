import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllCommande extends StatefulWidget {
  static void restartApp(BuildContext context) {
    // context.findAncestorStateOfType<_AllCommandeState>().;
  }

  @override
  _AllCommandeState createState() => _AllCommandeState();
}

class _AllCommandeState extends State<AllCommande> {
  var fs = Firestore.instance;
  QuerySnapshot com;
  SharedPreferences preferences;
  init() async {
    preferences = await SharedPreferences.getInstance();

    fs.collection("commandes").getDocuments().then((value) {
      setState(() {
        com = value;
        print(value);
      });
    });
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
        appBar: AppBar(
          title: Text("All Commande"),
          actions: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: (){

            })
          ],
        ),
        body: com == null
            ? Center(
                child: Text("No product"),
              )
            : ListView.builder(
              shrinkWrap: true,
                itemCount: com.documents.length,
                itemBuilder: (c, i) {
                  var d = [];
                  d=com.documents[i]["commande"];
                  print("lu ${com.documents[i]["lu"].toString().toLowerCase()}");
                  return com.documents[i]["uid"]==preferences.getString("uid")?ListView.builder(
                    shrinkWrap: true,
                      itemCount: d.length,
                      itemBuilder: (co, it) {
                        return Container(
                          color:com.documents[i]["lu"].toString().toLowerCase()=="oui"? Colors.green:Colors.red ,
                          child: ListTile(
                            
                            title: Text(d[it]["nom"]),
                          ),
                        );
                      }):null;
                }));
  }
}
