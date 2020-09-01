import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sums/home.dart';
import 'package:sums/login.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
String email="";
String mdp="";
bool isload=false;
FirebaseAuth auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MaterialButton(
        child: Text("Se connecter"),
        color: Colors.green,
        textColor: Colors.white,
        onPressed: (){
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (ctx)=>new Login())
          );
        },
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("SCREER UN COMPTE", style: TextStyle(fontSize: 25),),
              TextField(
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
                decoration: InputDecoration(hintText: "Email"
                ),
              ),
              TextField(
                onChanged: (val){
                  setState(() {
                    mdp=val;
                  });
                },
                decoration: InputDecoration(hintText: "Password"
                ),),
              FlatButton(
                onPressed: (){
                  setState(() {
                    isload=true;
                  });
              auth.createUserWithEmailAndPassword(
                  email: email, password: mdp).then((value) {
                print("Creation du compte reussie $value ${value.user}");
                Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (ctx)=>new Login()));
              }).catchError((err){
                print("erreur de creation de compte $err");
              }).whenComplete(() {
                setState(() {
                  isload=false;
                });
              });
                },
                child:isload?CircularProgressIndicator(): Text("CREER"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
