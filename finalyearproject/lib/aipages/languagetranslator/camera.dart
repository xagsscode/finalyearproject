import 'dart:io';
import 'package:camera/camera.dart';
import 'package:finalyearproject/aipages/languagetranslator/textrecogapi.dart';
import 'package:finalyearproject/aipages/languagetranslator/translation.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraWidget extends StatefulWidget {
  final CameraDescription camera;

  const CameraWidget({Key? key, required this.camera}) : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController cameraController;
  late Future<void> initCameraFn;
  String? shownText;
  String selectedLanguageCode = "en"; // Default language is English

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(widget.camera, ResolutionPreset.max);
    initCameraFn = cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FutureBuilder(
          future: initCameraFn,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CameraPreview(cameraController),
            );
          }),
        ),
        Positioned(
          bottom: 50,
          child: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            onPressed: () async {
              final image = await cameraController.takePicture();
              final recognizedText = await TextRecogApi.recognizeText(
                  InputImage.fromFile(File(image.path)));

              if (recognizedText == null) return;

              setState(() {
                shownText = recognizedText;
              });
            },
            child: const Icon(Icons.translate),
          ),
        ),
        if (shownText != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: Colors.black45,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: selectedLanguageCode,
                          items:
                              TranslationApi.supportedLanguages.map((language) {
                            return DropdownMenuItem<String>(
                              value: language["code"]!,
                              child: Text(language["name"]!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedLanguageCode = value!;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          shownText!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainTextColor),
                  onPressed: () async {
                    final translatedText = await TranslationApi.translateText(
                      shownText!,
                      selectedLanguageCode,
                    );

                    if (translatedText != null) {
                      setState(() {
                        shownText = translatedText;
                      });
                    }
                  },
                  child: Text("Translate"),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
