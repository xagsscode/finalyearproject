import 'package:finalyearproject/disabilities/fordeaf/deafdata.dart';
import 'package:finalyearproject/disabilities/fordeaf/detailcarddeaf.dart';
import 'package:finalyearproject/disabilities/fordeaf/modelfordeaf.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class SignLanguage extends StatelessWidget {
  String? perType;
  var data = DeafData();

  SignLanguage({super.key, this.perType});

  @override
  Widget build(BuildContext context) {
    List categList = [
      'Family',
      'Places',
      'Requests',
      'Time',
      'Feelings',
      'Numbers',
    ];
    List catIcon = [
      Icons.family_restroom,
      Icons.place_rounded,
      Icons.volunteer_activism_outlined,
      Icons.timelapse_sharp,
      Icons.emoji_emotions,
      Icons.format_list_numbered_rtl_rounded,
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          margin: EdgeInsets.only(left: 70),
          child: Text("Words to sign"),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Choose a category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250),
                itemCount: categList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                        CardsModel(
                          data: getDataForCategory(categList[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: DeafReuseCard(
                        text: categList[index],
                        icon: catIcon[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  model getDataForCategory(String category) {
    switch (category) {
      case 'Family':
        return data.familyData;
      case 'Places':
        return data.placesData;
      case 'Time':
        return data.timeData;
      case 'Requests':
        return data.requestData;
      case 'Feelings':
        return data.feelingsData;
      case 'Numbers':
        return data.numbersData;
      default:
        return data.familyData;
    }
  }
}
