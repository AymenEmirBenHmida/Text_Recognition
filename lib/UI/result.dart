//@dart=2.9
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translator/translator.dart';

class Result extends StatefulWidget {
  final String _text;
  Result(this._text);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextEditingController controller;
  GoogleTranslator translator = GoogleTranslator();
  String sourceLanguage = "eng";
  List<String> languages = [];
  String currentLanguage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController(text: widget._text);
    print("${controller.text} result text");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Translate({String to}) {
    translator.translate(widget._text, to: to).then((value) {
      setState(() {
        controller.text = value.text;
      });
    });
    sourceLanguage = currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.3),
        title: Text("Recognized Text"),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(controller.text);
              },
              icon: Icon(Icons.share)),
          IconButton(
              onPressed: () {
                FlutterClipboard.copy(controller.text);
              },
              icon: Icon(Icons.copy)),
          PopupMenuButton(
              elevation: 300,
              icon: Icon(Icons.translate),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("English"),
                      onTap: () {
                        setState(() {
                          currentLanguage = "en";
                          Translate(to: currentLanguage);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Arabic"),
                      onTap: () {
                        setState(() {
                          currentLanguage = "ar";
                          Translate(to: currentLanguage);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("French"),
                      onTap: () {
                        setState(() {
                          currentLanguage = "fr";
                          Translate(to: currentLanguage);
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Japanese"),
                      onTap: () {
                        setState(() {
                          currentLanguage = "ja";
                          Translate(to: currentLanguage);
                        });
                      },
                    ),
                  ])
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(15),
        width: double.infinity,
        height: double.infinity,
        child: Center(child:GestureDetector(
          onDoubleTap: () {
//controller.selection = TextSelection(baseOffset: 0, extentOffset: widget._text.length);
          },
          child: EditableText(
              textAlign: TextAlign.center,
              autofocus: true,
              maxLines: null,
              controller: controller,
              focusNode: FocusNode(),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              backgroundCursorColor: Colors.amber),
        ) /*
            Text(widget._text.isEmpty ? "there is no text" : widget._text)*/
        ,)
      ),
    );
  }
}
