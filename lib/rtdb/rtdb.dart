import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sums/custom_notification.dart';

class RTDB extends StatefulWidget {
  @override
  _RTDBState createState() => _RTDBState();
}

class _RTDBState extends State<RTDB> {
  DatabaseReference itemref;
  Item item;
  List<Item> items = List();
  FirebaseDatabase db = FirebaseDatabase();

  @override
  void initState() {
    super.initState();
    itemref = db.reference().child("item");
    itemref.onChildAdded.listen(_childAdded);
    itemref.onChildChanged.listen(_childChanged);
  }
<<<<<<< HEAD

  _childAdded(Event e) async {
    print("child added ${e.snapshot}");
    await SumsNotification.showNotification(
        "Codex", "${e.snapshot.value['nom']} disponnible");
// items.add(Item.fromSnap(e.snapshot));
  }
=======
_childAdded(Event e)async{
  print("child added ${e.snapshot}");
  await SumsNotification.showNotification("Codex","${e.snapshot.value['nom']} disponnible");
// items.add(Item.fromSnap(e.snapshot));
}

_childChanged(Event e){
  print("child changed ${e.snapshot}");
}
>>>>>>> 3232435ea2cc3f292802cea0c27e452d4f2ff443

  _childChanged(Event e) {
    print("child changed ${e.snapshot}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RTDB"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddItem()));
        },
        child: Icon(Icons.add),
      ),
      body: FirebaseAnimatedList(
          query: itemref,
          itemBuilder: (context, snap, animation, index) {
            return Container(
              color: snap.value["priorite"] ? Colors.red : Colors.green,
              child: ListTile(
                title: Text(snap.value["nom"]),
                subtitle: Text("${snap.value["prix"]}\$"),
                trailing: IconButton(
                    icon: Icon(Icons.sync),
                    onPressed: () {
                      print(snap.key);
                      itemref.child(snap.key).set({
                        "nom": snap.value["nom"],
                        "prix": snap.value["prix"],
                        "priorite": !snap.value["priorite"]
                      });
                    }),
              ),
            );
          }),
    );
  }
}

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  GlobalKey<FormState> fk = GlobalKey<FormState>();

  TextEditingController nom = TextEditingController();

  TextEditingController prix = TextEditingController();

  Item item;

  List<Item> items = List();

  DatabaseReference itemref = FirebaseDatabase().reference().child("item");

  bool send = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: nom,
            decoration: InputDecoration(hintText: "Nom"),
          ),
          TextFormField(
            controller: prix,
            decoration: InputDecoration(hintText: "Prix"),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                send = true;
              });
              item = new Item(nom.text, prix.text, false);
              itemref.push().set(item.toJson()).then((value) {
                print("push success");
                setState(() {
                  send = false;
                });
                Navigator.of(context).pop();
              });
            },
            child: send ? CircularProgressIndicator() : Text("Add"),
          )
        ],
      )),
    );
  }
}

class Item {
  String id, nom, prix;
  bool priorite;
  Item(this.nom, this.prix, this.priorite);
  Item.fromSnap(DataSnapshot snap)
      : id = snap.key,
        nom = snap.value["nom"],
        prix = snap.value["prix"],
        priorite = snap.value["priorite"];

  toJson() {
    return {"nom": nom, "prix": prix, "priorite": priorite};
  }
}
