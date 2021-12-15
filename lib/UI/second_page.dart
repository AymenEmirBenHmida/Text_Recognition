// ignore_for_file: deprecated_member_use
//@dart=2.9

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'flow_page.dart';

import 'result.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String _text = "";
  PickedFile _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingActionButton:FloatingActionButton(onPressed:() {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FlowMenu() ));},child: Text("flow"),),
      appBar: AppBar(
        backgroundColor: Colors.red.withOpacity(0.3),
        title: Text("Text Recognition"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                OcrMethod();
              },
              icon: Icon(Icons.scanner_outlined),
              label: Text("Scan")),
        ],
      ),
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: _image != null ? Image.file(File(_image.path)) : Container(),
        ),
        Padding(
          child: Align(
            alignment: Alignment.bottomRight,
            child: FlowMenu(
              onCountChanged: (int a) {
                print(a);
              },
              onCountSelected: (IconData a) {
                if (a == Icons.camera_alt_outlined) {
                  getImageCamera();
                }
                if (a == Icons.drive_file_move_outlined) {
                  getimage();
                }
              },
            ),
          ),
          padding: EdgeInsets.all(20),
        )
      ]),
    );
  }

  OcrMethod() async {
    showDialog(
        context: context,
        builder: (_) => Center(
              child: CircularProgressIndicator(),
            ));
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer Recognized = FirebaseVision.instance.textRecognizer();
    var i = 0;
    final VisionText visionText = await Recognized.processImage(visionImage);
    _text = '';
    for (var text in visionText.blocks) {
      for (TextLine Line in text.lines) {
        _text += Line.text + "\n";
        // i++;
        // print(_text + " this is the text gotten :: " + i.toString());
      }
    }
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Result(_text)));
  }

  getimage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print("No image selected");
      }
    });

    /*final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer Recognized = FirebaseVision.instance.textRecognizer();
    var i = 0;
    final VisionText visionText = await Recognized.processImage(visionImage);
    for (var text in visionText.blocks) {
      for (TextLine Line in text.lines) {
        _text += Line.text + "\n";
        i++;
        print(Line.text + " this is the text gotten :: " + i.toString());
      }
    }*/
  }

  getImageCamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        _image = pickedImage;
      } else {
        print("No image selected");
      }
    });
  }
}
