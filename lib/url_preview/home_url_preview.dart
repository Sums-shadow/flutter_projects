import 'package:flutter/material.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

class UrlPreview extends StatefulWidget {
  @override
  _UrlPreviewState createState() => _UrlPreviewState();
}

class _UrlPreviewState extends State<UrlPreview> {
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Url preview"),
      ),
      body: Center(
          child: Container(
        child: Column(
          children: [
            SimpleUrlPreview(
              url: "https://flutlab.io/",
              titleLines: 1,
              isClosable: true,
              previewHeight: 150,
              bgColor: Colors.blueGrey,
              textColor: Colors.white,
            ),
            TextField(
              onChanged: (val) {
                setState(() {
                  url = val;
                });
              },
              decoration: InputDecoration(hintText: "Entrer un url"),
            ),
          ],
        ),
      )),
    );
  }
}
