import 'package:finalyearproject/guides/acadamic.dart';
import 'package:finalyearproject/guides/admin.dart';
import 'package:finalyearproject/guides/culture.dart';
import 'package:finalyearproject/guides/recreation.dart';
import 'package:finalyearproject/guides/religion.dart';
import 'package:finalyearproject/guides/social.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> screnns = {
      "Academic": {
        "routeName": const AcademicGuide(),
        "icon": "assets/academics.jpg"
      },
      "Administrative": {"routeName": const AdminGuide(), "icon": "assets/admin.jpg"},
      "Social": {"routeName": const SocialGuide(), "icon": "assets/social.jpg"},
      "Cultural": {"routeName": const CultureGuide(), "icon": "assets/cultural.jpg"},
      "Recreational": {
        "routeName": const RecreationGuide(),
        "icon": "assets/recreat.jpg"
      },
      "Religious": {
        "routeName": const ReligionGuide(),
        "icon": "assets/religious.jpg"
      },
    };
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text(
        //     'Guides',
        //   ),
        // ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, bottom: 20),
              //   child: AppLargeText(text: "Categories"),
              // ),

              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0,
                    // Spacing between rows
                  ),
                  children: [
                    ...screnns.entries.map((screen) {
                      return MaterialButton(
                          onPressed: () {
                            Get.to(screen.value["routeName"]);
                          },
                          child: Container(
                            height: 170,
                            width: 170,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width - 10,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage(screen.value["icon"]),
                                          fit: BoxFit.fitHeight),
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  screen.key,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ));
                    })
                  ],
                ),
              ),

              // Expanded(
              //   child:
              //   GridView.builder(
              //     itemCount: 7,
              //       gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2, // Number of columns
              //     crossAxisSpacing: 16.0, // Spacing between columns
              //     mainAxisSpacing: 16.0,
              //     // Spacing between rows
              //   ) , itemBuilder: (context,index){
              //
              //     return MaterialButton(
              //       onPressed: () {
              //         Get.to();
              //       },
              //       child: MyContainer(
              //         image: 'assets/academics.jpg',
              //         icon: FontAwesomeIcons.bookOpen,
              //         text: 'Acadamic',
              //         color: AppColors.mainTextColor,
              //       ),
              //     );
              //
              //   }),
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     MaterialButton(
              //       onPressed: () {
              //         Get.to(AcademicGuide());
              //       },
              //       child: MyContainer(
              //         image: 'assets/academics.jpg',
              //         icon: FontAwesomeIcons.bookOpen,
              //         text: 'Acadamic',
              //         color: AppColors.mainTextColor,
              //       ),
              //     ),
              //     MaterialButton(
              //       onPressed: () {
              //         Get.to(AdminGuide());
              //       },
              //       child: MyContainer(
              //         image: 'assets/admin.jpg',
              //         icon: FontAwesomeIcons.desktop,
              //         text: 'Adminstrative',
              //         color: AppColors.mainTextColor,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     MaterialButton(
              //       onPressed: () {
              //         Get.to(SocialGuide());
              //       },
              //       child: MyContainer(
              //         image: 'assets/social.jpg',
              //         icon: FontAwesomeIcons.userGroup,
              //         text: 'Social',
              //         color: AppColors.mainTextColor,
              //       ),
              //     ),
              //     MaterialButton(
              //       onPressed: () {
              //         Get.to(CultureGuide());
              //       },
              //       child: MyContainer(
              //         image: 'assets/cultural.jpg',
              //         icon: FontAwesomeIcons.person,
              //         text: 'Cultural',
              //         color: AppColors.mainTextColor,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     MaterialButton(
              //       onPressed: () {
              //         Get.to(RecreationGuide());
              //       },
              //       child: MyContainer(
              //         image: 'assets/recreat.jpg',
              //         icon: FontAwesomeIcons.tents,
              //         text: 'Recreational',
              //         color: AppColors.mainTextColor,
              //       ),
              //     ),
              //     MaterialButton(
              //       onPressed: () {
              //         Get.to(Get.to(ReligionGuide()));
              //       },
              //       child: MyContainer(
              //         image: 'assets/religious.jpg',
              //         icon: FontAwesomeIcons.starAndCrescent,
              //         text: 'Religious',
              //         color: AppColors.mainTextColor,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ));
  }
}
