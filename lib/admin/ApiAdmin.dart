import 'package:cloud_firestore/cloud_firestore.dart';

class ApiAdmin{
  final Firestore  db=Firestore.instance;

   String path;
  CollectionReference ref;
  ApiAdmin(this.path){
    ref=db.collection(path);
  }
}