
/*
//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed:(() => OcrMethod()),
          child: Text("open camera"),
        ),
      ),
    );
  }

  OcrMethod() async {
    List<OcrText> list = [];

  //  try {
      list = await FlutterMobileVision.read(
        waitTap: true,
        fps: 3,
      );
      var i = 0;
      for (OcrText text in list) {
        i++;
        print(" ${i} ::this is the text gotten" + text.value.toString());
      }
   // } catch (e) {
     // print(e.toString());
    //}
  }
}*/
