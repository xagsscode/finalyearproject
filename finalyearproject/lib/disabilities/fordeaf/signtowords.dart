import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignToWords extends StatelessWidget {
  const SignToWords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Help me with some money pls"),
              SizedBox(
                height: 20,
              ),
              Text("Where is the admin block")
            ],
          ),
        ),
      ),
    );
  }
}
