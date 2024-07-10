import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppLargeText(
      {super.key,
      this.size = 30,
      required this.text,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w800),
    );
  }
}

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppText(
      {super.key,
      this.size = 16,
      required this.text,
      this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size),
    );
  }
}

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  ResponsiveButton({super.key, this.isResponsive = false, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.mainColor),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  double? size;
  double? width;
  Color? color;
  Color? color2;
  LoginButton(
      {super.key,
      required this.text,
      this.size,
      this.width = 250,
      this.color,
      this.color2});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color,
            border: Border.all(width: 1, color: AppColors.mainColor)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: size, color: color2),
        ));
  }
}

class MyContainer extends StatelessWidget {
  double? height;
  double? width;
  Color? color;
  IconData icon;
  String text;
  String image;
  MyContainer(
      {super.key,
      required this.icon,
      required this.text,
      this.height = 170,
      this.width = 160,
      this.color,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: ClipOval(
                child: Image(
                  image: AssetImage(image),
                  width: 120,
                  height: 120,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class CircleIndicator extends Decoration {
  final Color color;
  double radius;
  CircleIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter

    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;

    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}

class DeafReuseCard extends StatelessWidget {
  String text;
  IconData icon;
  DeafReuseCard({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 180,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: AppColors.mainColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 60,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 130,
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.purpleAccent,
            ),
          ),
        ],
      ),
    );
  }
}
