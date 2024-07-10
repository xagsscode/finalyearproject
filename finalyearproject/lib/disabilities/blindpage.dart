import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class BlindPage extends StatefulWidget {
  @override
  BlindPageState createState() => BlindPageState();
}

class BlindPageState extends State<BlindPage> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> speak() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.speak(
        'Your feature will be available soon. you will not be left behind because this app is designed to help both disabled and normal students of bayero university kano');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Text to Speech'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: speak,
          child: Container(
            height: 700,
            width: 700,
            color: AppColors.mainColor,
            child: Center(
                child: Text(
              "Tap anywhere to listen",
              style: TextStyle(color: Colors.black, fontSize: 25),
            )),
          ),
        ),
      ),
    );
  }
}
