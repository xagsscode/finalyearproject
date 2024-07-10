import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<SliderScreen> {
  List text = ['Student Guide', '', ''];
  List text1 = ['Bayero university', '', ''];
  List text2 = [
    'This app will guide you  with your school activities, and help you connect with other students within campus',
    '',
    ''
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: PageView.builder(itemBuilder: (_, index) {
        return Container(
          margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLargeText(text: text[index]),
                  AppText(
                    text: text1[index],
                    size: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 250,
                    child: AppText(
                      text: text2[index],
                      color: Colors.black,
                      size: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 350,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (indexDots) {
                  return Container(
                    margin: const EdgeInsets.only(right: 3),
                    height: 8,
                    width: index == indexDots ? 25 : 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: index == indexDots
                            ? AppColors.mainColor
                            : AppColors.mainColor.withOpacity(0.3)),
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResponsiveButton(
                      width: 100,
                    ),
                    ResponsiveButton(
                      width: 100,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
