import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyearproject/detailpage/detailadmin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminGuide extends StatefulWidget {
  const AdminGuide({Key? key}) : super(key: key);

  @override
  State<AdminGuide> createState() => _MainScreenState();
}

class _MainScreenState extends State<AdminGuide> {
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
                    "Admistrative",
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
                List<Map<String, dynamic>> adminData = data['admin'];
                List<Map<String, dynamic>> stepsData = data['steps'];

                return ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: adminData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        int stepIndex = adminData[index]['stepIndex'];
                        Get.to(
                          AdminDetailPage(
                            headingName: adminData[index]['name'],
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
                                adminData[index]['name'],
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
          await FirebaseFirestore.instance.collection("Admin").get();

      print("Admin Snapshot: ${academicsSnapshot.docs}");

      List<Map<String, dynamic>> adminData = academicsSnapshot.docs
          .map((doc) => {
                'name': doc['name'],
                'stepIndex': doc['stepIndex'],
                // Add other fields as needed
              })
          .toList();

      // Fetch data from "Steps" collection
      QuerySnapshot stepsSnapshot = await FirebaseFirestore.instance
          .collection("Stepsforadmin")
          // .orderBy('', descending: false)
          .get();

      print("Stepsforadmin Snapshot: ${stepsSnapshot.docs}");

      List<Map<String, dynamic>> stepsData = stepsSnapshot.docs
          .map((doc) => {
                'step': (doc.data() as Map<String, dynamic>),
                // Add other fields as needed
              })
          .toList();

      print("Admin Data: $adminData");
      print("Stepsforadmin Data: $stepsData");

      return {'admin': adminData, 'steps': stepsData};
    } catch (e) {
      print('Error fetching data: $e');
      return {
        'admin': <Map<String, dynamic>>[], // Ensure the correct data type
        'steps': <Map<String, dynamic>>[], // Ensure the correct data type
      }; // Return empty lists in case of an error
    }
  }
}