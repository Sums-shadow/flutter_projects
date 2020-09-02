import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpecheeText extends StatefulWidget {
  @override
  _SpecheeTextState createState() => _SpecheeTextState();
}

class _SpecheeTextState extends State<SpecheeText> {
  stt.SpeechToText _speech;
  bool isListening = false;
  String text = "appyer sur le bouton pour enregistrer";
  String t = ".";
  double confidence = 1.0;
  final Map<String, HighlightedWord> highlights = {
    'fina': HighlightedWord(
        onTap: () {
          print("appuyer");
        },
        textStyle: TextStyle(
            fontSize: 32, fontStyle: FontStyle.italic, color: Colors.blue)),
    'bonjour': HighlightedWord(
        onTap: () {
          print("bonjour");
        },
        textStyle: TextStyle(
            fontSize: 32, fontStyle: FontStyle.italic, color: Colors.yellow)),
    'bonsoir': HighlightedWord(
        onTap: () {
          print("bonsoir");
        },
        textStyle: TextStyle(
            fontSize: 32, fontStyle: FontStyle.italic, color: Colors.grey)),
    'd\'accord': HighlightedWord(
        onTap: () {
          print("accord");
        },
        textStyle: TextStyle(
            fontSize: 32, fontStyle: FontStyle.italic, color: Colors.green)),
    'jesus': HighlightedWord(
        onTap: () {
          print("jesus");
        },
        textStyle: TextStyle(color: Colors.red)),
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Speech to tex ${(confidence * 100.0).toStringAsFixed(1)}%"),
      ),
      floatingActionButton: AvatarGlow(

        animate: isListening,
        glowColor: Colors.green,
        endRadius: 75.0,
        duration: Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: TextHighlight(
            text: text,

            words: highlights,
            textStyle: TextStyle(
                fontSize: 32, color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  _listen() async {
    if (!isListening) {
      bool a = await _speech.initialize(
          onStatus: (val) {
            print("statut $val");
          },
          onError: (val) => print("error statut $val"));
      if (a) {
        setState(() {
          isListening = true;
        });

        _speech.listen(onResult: (val) {
          setState(() {
            text = val.recognizedWords;
            print(val.toString());
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
              setState(() {
               text= text.replaceAll("appuyer", "fina");
               text= text.replaceAll("bonjour", "mbote");
               text= text.replaceAll("comment", "boni");
               text= text.replaceAll("mariage", "libala");
                 
              });
            
          });
        });
      }
    } else {
      setState(() {
        isListening = false;
      });
      _speech.stop();
    }
  }
}
