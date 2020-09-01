import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sums/home.dart';
import 'package:sums/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences=await SharedPreferences.getInstance();
  preferences.getBool("isLogin")==null?runApp(MyApp()):runApp(MyApps());
// print("Email ${preferences.getString('email')}");
// print("UID ${preferences.getString('uid')}");
// print("Is Login ${preferences.getBool('isLogin')}");

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   
   
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:Login(),
    );
  }
}
 


class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:Home(),
    );
  }
}