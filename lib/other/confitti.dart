import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';



class Confitti extends StatefulWidget {
  @override
  _ConfittiState createState() => _ConfittiState();
}

class _ConfittiState extends State<Confitti> {
  ConfettiController conf;

  @override
  void initState() {
    super.initState();
    conf=ConfettiController(duration: Duration(seconds: 1));
  }
  @override
  void dispose() {
    super.dispose();
    conf.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Confitti"),),
        body: Stack(
          children: [
         
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             RaisedButton(onPressed: ()=>conf.play(), child: Text("Play"),),
ConfettiWidget(displayTarget: false,gravity: 1, confettiController: conf, numberOfParticles: 10, blastDirectionality: BlastDirectionality.explosive, shouldLoop: true, colors: [Colors.green, Colors.red, Colors.pink, Colors.blue],),

         RaisedButton(onPressed: ()=>conf.stop(), child: Text("Stop"),)
           ],
         )
          ],
        ),
    );
  }
}