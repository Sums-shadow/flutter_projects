import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sums/admin/admin_home.dart';
import 'package:sums/api/homeapi.dart';
import 'package:sums/custom_notification.dart';
import 'package:sums/ecommerce/home_ecom.dart';
import 'package:sums/localisation/home_localisation.dart';
import 'package:sums/login.dart';
import 'package:sums/notification/notification.dart';
import 'package:sums/other/confitti.dart';
import 'package:sums/quiz/home_quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sums/rtdb/rtdb.dart';
import 'package:sums/speech/speechtext.dart';
import 'package:sums/speech/textSpeech.dart';
import 'package:sums/url_preview/home_url_preview.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String user;
  SharedPreferences preferences;
  String message = "Bienvenue";

 
  
  init() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      user = preferences.getString("email").split("@")[0];
      message = "$message $user";
      print("Email ${preferences.getString('email')}");
      print("UID ${preferences.getString('uid')}");
      print("Is Login ${preferences.getBool('isLogin')}");
    });
  }

  @override
  void initState() {
    init();
 
    super.initState();
  }
 
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: MyAppBar(),
        drawer:myDrawer(),
          body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              color: Colors.blue,
              onPressed: ()async{
                await SumsNotification.showNotification("Codex","un nouveau produit disponnible");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Show Notification",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Text(
                message,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ],
        ));
  }


  Widget myDrawer(){
    return Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Ecommerce"),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (ctx) => new HomeEcommerce()));
                },
              ),
              
              ListTile(
                title: Text("Admin"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new Admin_Home()));
                },
              ),
              ListTile(
                title: Text("API"),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (ctx) => new HomeApi()));
                },
              ),
              ListTile(
                title: Text("Localisation"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new Home_Localisation()));
                },
              ),
              ListTile(
                title: Text("Quiz"),
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (ctx) => new Home_Quiz()));
                },
              ),
              ListTile(
                title: Text("url_preview"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new UrlPreview()));
                },
              ),
              ListTile(
                title: Text("speech to text"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new SpecheeText()));
                },
              ),
              ListTile(
                title: Text("text to speech"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new TextSpeech()));
                },
              ),
               ListTile(
                title: Text("confitti"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new Confitti()));
                },
              ),
              ListTile(
                title: Text("Rtdb"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new RTDB()));
                },
              ),
              ListTile(
                title: Text("Notification"),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (ctx) => new Notifications()));
                },
              ),
            ],
          ),
        );
      
  }

  Widget MyAppBar(){
    return AppBar(
          title: Text("Sums"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  auth.signOut();
                  preferences.remove("uid");
                  preferences.remove("email");
                  preferences.remove("isLogin");
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (ctx) => new Login()));
                })
          ],
        );
  }
}
