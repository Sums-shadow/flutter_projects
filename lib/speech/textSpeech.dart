import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextSpeech extends StatefulWidget {
  @override
  _TextSpeechState createState() => _TextSpeechState();
}

class _TextSpeechState extends State<TextSpeech> {
  FlutterTts ft = FlutterTts();
  String current = "";
  int etat=0;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" text Speech"),
        actions: [
Text("Mot: ${etat.toString()}"),

        ],
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          ft.stop();
          Navigator.pop(context);

        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          current="";
          await ft.setLanguage("fr-CA");
          await ft.speak(
              "Ainsi, au sein de l’entreprise, nombre de situations amènent ce genre d’exercice. Il en est de même dans la vie familiale lors d’évènements tels qu’un baptême , une communion, un mariage, un décès, un anniversaire, etc. Et l’amour ? N’avez-vous jamais pensé et repensé comment vous alliez faire une déclaration ou un discours à votre bien-aimé(e) ? ");
          print("langue: ${ft.getVoices}");
          ft.setProgressHandler(
              (String text, int strt, int nd, String word) {
            setState(() {
              print("word $word  $strt $nd");
              setState(() {
                current += " " + word;
                etat=word.length;
              });
            });
          });
        },
        child: Text("Play"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Wrap(
              children: [Text(current)],
            ),
          )
        ],
      ),
    );
  }
}
