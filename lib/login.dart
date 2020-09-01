import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sums/constant.dart';
import 'package:sums/home.dart';
import 'package:sums/register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth =FirebaseAuth.instance;


  String email="";
  String mdp="";
  bool isLoad=false;
  SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MaterialButton(
        child: Text("Creer un compte"),
        color: Colors.green,
        textColor: Colors.white,
        onPressed: (){
          Navigator.of(context).push(
            new MaterialPageRoute(builder: (ctx)=>new Register())
          );
        },
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("SE CONNECTER", style: TextStyle(fontSize: 25),),
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
              RaisedButton(onPressed: () async{
                setState(() {
                  isLoad=true;
                });
                preferences=await SharedPreferences.getInstance();
                print("email $email and password $mdp");
               try {
                  auth.signInWithEmailAndPassword(email: email, password: mdp).then((value){
                 print("valeur recu ${value.user}");
                 preferences.setString("uid", value.user.uid);
                 preferences.setString("email", value.user.email);
                 preferences.setBool("isLogin", true);
                 user_email=value.user.email;
                 Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (ctx)=>new Home()));
               }).catchError((err){
                 print("error on loginn $err.");
               }).whenComplete(() {
                 setState(() {
                   isLoad=false;
                 });
               });
               } catch (e) {
                 print("error on login");
               }

//                  print("utilisateur ${user.uid}");
              },child: isLoad? CircularProgressIndicator(): Text("Taper"),)
            ],
          ),
        ),
      ),
    );
  }

}
