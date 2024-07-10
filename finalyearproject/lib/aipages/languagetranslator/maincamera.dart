import 'package:camera/camera.dart';
import 'package:finalyearproject/aipages/languagetranslator/camera.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainCamera extends StatelessWidget {
  const MainCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CameraDescription>>(
          future: availableCameras(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return const Center(
                child: Text("Error"),
              );
            }
            final cameras = snapshot.data!.first;
            return CameraWidget(camera: cameras);
          })),
    );
  }
}

class startScreen extends StatelessWidget {
  const startScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 80), child: Text("WELCOME")),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.mainColor),
          child: InkWell(
            onTap: () {
              Get.to(const MainCamera());
            },
            child: Center(
                child: Text(
              "Translate",
              style: TextStyle(fontSize: 25),
            )),
          ),
        ),
      ),
    );
  }
}
