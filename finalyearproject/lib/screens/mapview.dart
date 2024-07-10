import 'package:finalyearproject/screens/secondscreen.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:finalyearproject/widgetrefactor/reuseclass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({Key? key}) : super(key: key);

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  var defaultLocations = {
    modelMap(["11.9663"], ["8.4305"]): 'buk current location to central mosque',
    modelMap(["11.9640"], ["8.4278"]): 'buk current location to stadium',
    modelMap(["11.9666"], ["8.4281"]):
        'buk current location to convocation arena',
    modelMap(["11.9751"], ["8.4270"]): 'buk current location to library',
    modelMap(["11.9717"], ["8.4234"]): 'buk current location to cock village',
    modelMap(["11.9710, "], ["8.4237"]):
        'buk current location to student affairs',
    modelMap(["11.9745"], ["8.4248"]): 'buk current location to cit center',
    modelMap(["11.9721"], ["8.4234"]):
        'buk current location to post graduate hall',
    modelMap(["11.9716"], ["8.4257"]):
        'buk current location to senate building',
    modelMap(["11.9658"], ["8.4263"]):
        'buk current location to faculty of communication',
    modelMap(["11.9681"], ["8.4222"]): 'buk current location to faculty of law',
    modelMap(["11.9663"], ["8.4305"]):
        'buk current location to faculty of engineering',
    modelMap(["11.9752"], ["8.4252"]):
        'buk current location to faculty of computing',
    modelMap(["11.9752"], ["8.4252"]):
        'buk current location to theatre A faculty of computing',
    modelMap(["11.9752"], ["8.4252"]):
        'buk current location to cit theatre  faculty of computing',
    modelMap(["11.9749"], ["8.4249"]):
        'buk current location to faculty agriculture',
    modelMap(["11.9744"], ["8.4275"]):
        'buk current location to faculty of art and islamic studies',
    modelMap(["11.9776"], ["8.4270"]):
        'buk current location to faculty of earth and environmental sciences',
  };

  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null) {
      user = auth.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Center(
      //       child: Text(
      //     'Bayero University Map',
      //   )),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   'Search for location',
            //   style: TextStyle(fontSize: 20),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // // Text('${user?.photoURL}'),
            // const SizedBox(height: 30),
            TextField(
              controller: latController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Latitude',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: lngController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Longitude',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => MapPage(
                  //     lat: double.parse(latController.text),
                  //     lng: double.parse(lngController.text),
                  //   ),
                  // ));

                  Get.to(
                    MapPage(
                      lat: double.parse(latController.text),
                      lng: double.parse(lngController.text),
                    ),
                  );
                },
                child: AppText(
                  text: "GET DIRECTIONS",
                  color: AppColors.textColor1,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showLocationListBottomSheet(context);
        },
        backgroundColor: AppColors.mainColor,
        child: const Icon(
          Icons.list,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showLocationListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: defaultLocations.length,
          itemBuilder: (BuildContext context, int index) {
            var entry = defaultLocations.entries.elementAt(index);
            var location = entry.key;
            var description = entry.value;
            return ListTile(
              leading: Icon(
                Icons.location_on,
                color: AppColors.mainColor,
              ),
              title: Text(description),
              subtitle: Text(location.lat[0] + ", " + location.lng[0]),
              onTap: () {
                setState(() {
                  latController.text = location.lat[0];
                  lngController.text = location.lng[0];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
