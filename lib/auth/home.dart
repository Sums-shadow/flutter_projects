import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sums/auth/login.dart';

class HomeAuth extends StatefulWidget {
  @override
  _HomeAuthState createState() => _HomeAuthState();
}

class _HomeAuthState extends State<HomeAuth> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Auth"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Welcome"),
            RaisedButton(
              child: Text("Se deconnecter"),
              onPressed: () {
                googleSignIn.signOut().then((value) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=>LoginAuth())));
              },
            )
          ],
        ),
      ),
    );
  }
}
