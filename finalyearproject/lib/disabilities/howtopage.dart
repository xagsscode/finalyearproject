import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HowtoPage extends StatelessWidget {
  const HowtoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Use the voice chat to chat with the deaf in campus"),
              SizedBox(
                height: 20,
              ),
              Text("Use sign language to communicate with deaf"),
              SizedBox(
                height: 20,
              ),
              Text("Deaf can use quick request for emergency"),
              SizedBox(
                height: 20,
              ),
              Text("Show the text to speech page for the blind"),
            ]),
      ),
    );
  }
}
