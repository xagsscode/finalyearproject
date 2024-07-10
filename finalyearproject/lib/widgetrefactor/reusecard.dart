import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  String text;
  String image;
  Color? color;
  VoidCallback onpressed;

  CustomCard(
      {super.key,
      required this.text,
      required,
      required this.image,
      required this.onpressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // Set the clip behavior of the card
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                image,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(height: 10),
                  Text(
                    'Use our AI features',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: AppColors.mainColor),
                        child: const Text(
                          "TRY",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: onpressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondCard extends StatelessWidget {
  final String text;
  final String image;
  double? height;
  double? width;
  double? secondHeight;
  double? secondWidth;
  SecondCard(
      {super.key,
      required this.text,
      required this.image,
      this.height = 200,
      this.width = 350,
      this.secondHeight = 150,
      this.secondWidth = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.mainColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    height: secondHeight,
                    width: secondWidth,
                  ),
                  Text(
                    text,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
