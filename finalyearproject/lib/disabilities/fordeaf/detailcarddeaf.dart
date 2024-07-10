import 'package:finalyearproject/disabilities/fordeaf/deafdata.dart';
import 'package:finalyearproject/disabilities/fordeaf/modelfordeaf.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CardsModel extends StatelessWidget {
  final model data;
  const CardsModel({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0))),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Text(
                    "Sign Language",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: data.cardsname.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FlipCard(
                  front: Container(
                    child: Card(
                      color: AppColors.mainColor,
                      elevation: 4,
                      shadowColor: const Color.fromRGBO(190, 18, 277, 1),
                      margin: const EdgeInsets.all(10),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 0)),
                      child: Center(
                        child: InkWell(
                            onTap: () async {
                              await flutterTts.speak(data.cardsname[index]);
                            },
                            child: Text(
                              data.cardsname[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  back: Card(
                    color: AppColors.mainColor,
                    elevation: 4,
                    shadowColor: const Color.fromRGBO(190, 18, 277, 2),
                    margin: const EdgeInsets.all(10),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                      ),
                    ),
                    child: Image.network(
                      data.src[index],
                      // scale: 5,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
