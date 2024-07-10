import 'package:finalyearproject/aipages/gemini/gemini.dart';
import 'package:finalyearproject/aipages/languagetranslator/camera.dart';
import 'package:finalyearproject/aipages/languagetranslator/maincamera.dart';
import 'package:finalyearproject/aipages/speechtotext/speech.dart';
import 'package:finalyearproject/aipages/textextraction/extraction.dart';
import 'package:finalyearproject/welcomestuff/login.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/reusecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AiPage extends StatefulWidget {
  const AiPage({Key? key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  @override
  Widget build(BuildContext context) {
    List pages = [
      const startScreen(),
      const GeminiPage(),
      const TextExtraction(),
      const SpeechPage(),
    ];

    var imageText = {
      "lang.png": "Language-Translator-AI",
      "gemini.png": "BUK-Gemini",
      "text2.jpg": "Text-Extraction",
      "speech.png": "Speech-To-Text"
    };

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   margin: const EdgeInsets.only(top: 40, left: 30),
          //   child: const Text(
          //     'Welcome\n Enjoy our AI features',
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: CustomCard(
                    text: imageText.values.elementAt(index),
                    image: 'assets/${imageText.keys.elementAt(index)}',
                    onpressed: () {
                      Get.to(pages[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    // body: SingleChildScrollView(
    //   padding: EdgeInsets.only(bottom: 16), // Adjust bottom padding as needed
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    // Container(
    // margin: const EdgeInsets.only(top: 40, left: 30),
    // child: const Text(
    //   'Welcome\n Enjoy our AI features',
    //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    // ),
    // ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Column(
    //         children: [
    //           CustomCard(
    //             text: 'Language-Translator-AI',
    //             image: 'assets/stu7.jpg',
    //             onpressed: () {
    //               Get.to(const startScreen());
    //             },
    //           ),
    //           CustomCard(
    //             text: 'BUK-Gemini',
    //             image: 'assets/stu7.jpg',
    //             onpressed: () {
    //               Get.to(const GeminiPage());
    //             },
    //           ),
    //           CustomCard(
    //             text: 'Entity-Text-Translation',
    //             image: 'assets/stu7.jpg',
    //             onpressed: () {
    //               Get.to(());
    //             },
    //           ),
    //           CustomCard(
    //               text: 'Speech-To-Text',
    //               image: 'assets/stu7.jpg',
    //               onpressed: () {
    //                 Get.to(());
    //               }),
    //         ],
    //       ),
    //     ],
    //   ),
    // ),
  }
}
