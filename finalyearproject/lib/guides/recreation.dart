import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/detailpage/detailcultural.dart';
import 'package:finalyearproject/detailpage/detailrec.dart';
import 'package:finalyearproject/detailpage/detailsocial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecreationGuide extends StatefulWidget {
  const RecreationGuide({Key? key}) : super(key: key);

  @override
  State<RecreationGuide> createState() => _RecreationGuideState();
}

class _RecreationGuideState extends State<RecreationGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back(); // Use Get.back() to navigate back
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  const Text(
                    "Recreational",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _getData(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                Map<String, dynamic> data = snapshot.data!;
                List<Map<String, dynamic>> rectdata = data['rect'];
                List<Map<String, dynamic>> stepsData = data['steps'];

                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: rectdata.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        int stepIndex = rectdata[index]['stepIndex'];
                        Get.to(
                          RectDetailPage(
                            headingName: rectdata[index]['name'],
                            steps: (stepsData[stepIndex]['step']
                                    as Map<String, dynamic>)
                                .values
                                .map((step) => step.toString())
                                .toList(),
                            // Add any additional data you want to pass to the detail page.
                          ),
                        );
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                rectdata[index]['name'],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _getData() async {
    try {
      // Fetch data from "Academics" collection
      QuerySnapshot academicsSnapshot =
          await FirebaseFirestore.instance.collection("Recreation").get();

      print("Recreation Snapshot: ${academicsSnapshot.docs}");

      List<Map<String, dynamic>> rectdata = academicsSnapshot.docs
          .map((doc) => {
                'name': doc['name'],
                'stepIndex': doc['stepIndex'],
                // Add other fields as needed
              })
          .toList();

      // Fetch data from "Steps" collection
      QuerySnapshot stepsSnapshot = await FirebaseFirestore.instance
          .collection("Stepsforrect")
          // .orderBy('', descending: false)
          .get();

      print("Stepsforrect Snapshot: ${stepsSnapshot.docs}");

      List<Map<String, dynamic>> stepsData = stepsSnapshot.docs
          .map((doc) => {
                'step': (doc.data() as Map<String, dynamic>),
                // Add other fields as needed
              })
          .toList();

      print("Recreation Data: $rectdata");
      print("Stepforrect Data: $stepsData");

      return {'rect': rectdata, 'steps': stepsData};
    } catch (e) {
      print('Error fetching data: $e');
      return {
        'rect': <Map<String, dynamic>>[], // Ensure the correct data type
        'steps': <Map<String, dynamic>>[], // Ensure the correct data type
      }; // Return empty lists in case of an error
    }
  }
}