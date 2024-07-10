import 'dart:ffi';
import 'dart:io';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextExtraction extends StatefulWidget {
  const TextExtraction({super.key});

  @override
  State<TextExtraction> createState() => _TextExtractionState();
}

class _TextExtractionState extends State<TextExtraction> {
  File? _image;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        _image = File(PickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image to text')),
      body: Center(
        child: _image == null
            ? const Text('No image selected')
            : Column(
                children: [
                  Image.file(
                    _image!,
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor),
                      onPressed: () {
                        readTextFromImage();
                      },
                      child: const Text(
                        'Get Text',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: getImageFromGallery,
        tooltip: 'select image',
        child: const Icon(
          Icons.image,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> readTextFromImage() async {
    final inputImage = InputImage.fromFile(_image!);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Extracted Text'),
          content: SingleChildScrollView(child: Text(text)),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Text copied to clipboard')),
                );
              },
              child: const Text('Copy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
