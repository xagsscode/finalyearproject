import 'dart:async';
import 'dart:math';

import 'package:finalyearproject/screens/mainpage.dart';
import 'package:finalyearproject/screens/mapview.dart';
import 'package:finalyearproject/widgetrefactor/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  double lat;
  double lng;
  MapPage({super.key, required this.lat, required this.lng});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = const LatLng(11.9729, 8.4258);
  StreamSubscription<loc.LocationData>? locationSubscribtion;
  @override
  void initState() {
    super.initState();
    getNavigation();
    addMarker();
  }

  getNavigation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscribtion =
          location.onLocationChanged.listen((LocationData currentLocation) {
        controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 16,
        )));
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            curLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId(currentLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
                  title:
                      '${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)))} km'),
              onTap: () {
                print('market tapped');
              },
            );
          });
          getDirections(LatLng(widget.lat, widget.lng));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyA9mu4xFJDCBimBk2mn8MA2bwPe9JwmY3s',
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(dst.latitude, dst.longitude),
        travelMode: TravelMode.walking);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: const MarkerId('source'),
        position: curLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      destinationPosition = Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      );
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(curLocation.latitude, curLocation.longitude,
        destposition.latitude, destposition.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: Text("Navigate"),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            await launchUrl(Uri.parse(
                'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyA9mu4xFJDCBimBk2mn8MA2bwPe9JwmY3s'));
          },
          icon: const Icon(
            Icons.navigation_outlined,
            color: Colors.white,
          )),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: sourcePosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              scrollGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: Set<Polyline>.of(polylines.values),
              initialCameraPosition: CameraPosition(
                target: curLocation,
                zoom: 16,
              ),
              markers: {sourcePosition!, destinationPosition!},
              onTap: (latLng) {
                print(latLng);
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
      // Stack(
      //         children: [
      //           GoogleMap(
      //             scrollGesturesEnabled: true,
      //             zoomControlsEnabled: false,
      //             polylines: Set<Polyline>.of(polylines.values),
      //             initialCameraPosition: CameraPosition(
      //               target: curLocation,
      //               zoom: 16,
      //             ),
      //             markers: {sourcePosition!, destinationPosition!},
      //             onTap: (latLng) {
      //               print(latLng);
      //             },
      //             onMapCreated: (GoogleMapController controller) {
      //               _controller.complete(controller);
      //             },
      //           ),
      //           Positioned(
      //             top: 30,
      //             left: 15,
      //             child: GestureDetector(
      //               onTap: () {
      //                 Navigator.of(context).pushAndRemoveUntil(
      //                     MaterialPageRoute(
      //                         builder: (context) => const MapViewPage()),
      //                     (route) => false);
      //               },
      //               child: const Icon(Icons.arrow_back),
      //             ),
      //           ),
      //           Positioned(
      //               bottom: 10,
      //               right: 10,
      //               child: Container(
      //                 width: 50,
      //                 height: 50,
      //                 decoration: BoxDecoration(
      //                     shape: BoxShape.circle, color: AppColors.mainColor),
      //                 child: Center(
      //                   child: IconButton(
      //                     icon: const Icon(
      //                       Icons.navigation_outlined,
      //                       color: Colors.white,
      //                     ),
      //                     onPressed: () async {
      //                       await launchUrl(Uri.parse(
      //                           'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyBoVyWaLcGQY_0R-OJpkeQiRdmFHAFEEpk'));
      //                     },
      //                   ),
      //                 ),
      //               ))
      //         ],
      //       ),
    );
  }
}

class modelMap {
  List<dynamic> lat = [];
  List<dynamic> lng = [];

  modelMap(this.lat, this.lng);
}
