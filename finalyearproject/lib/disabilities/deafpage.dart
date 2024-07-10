import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/disabilities/fordeaf/signlanguage.dart';
import 'package:finalyearproject/disabilities/fordeaf/signtowords.dart';
import 'package:finalyearproject/disabilities/fordeaf/voice.dart';
import 'package:finalyearproject/widgetrefactor/reusecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeafPage extends StatefulWidget {
  const DeafPage({super.key});

  @override
  State<DeafPage> createState() => _DeafPageState();
}

class _DeafPageState extends State<DeafPage> {
  @override
  Widget build(BuildContext context) {
    var images = {
      "Chat1.png": "Voice chat",
      "img1.png": "Words to sign language",
      "img.png": "Quick request"
    };

    List pages = [VoiceChat(), SignLanguage(), SignToWords()];
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back)),
          title: Text("choose an option"),
          actions: [],
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(pages[index]);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SecondCard(
                      text: images.values.elementAt(index),
                      image: "assets/${images.keys.elementAt(index)}"),
                ),
              );
            },
          ),
        ));
  }
}
