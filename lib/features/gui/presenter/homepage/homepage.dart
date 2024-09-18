import 'dart:io';
import 'dart:math';

import 'package:android_intent_plus/android_intent.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hike_mates/features/gui/constants/map_camera_position.dart';
import 'package:hike_mates/features/gui/controllers/map_string_controller.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';
import 'package:hike_mates/features/gui/ui/drawer/drawer.dart';
import 'package:hike_mates/features/gui/ui/drawer/emergency_contacts.dart';
import 'package:hike_mates/features/gui/ui/routers/app_router.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  final bool isLoggedIn;

  HomePage(this.isLoggedIn, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final logger = Logger();
  MapboxMapController? _mapController;
  double _zoomLevel = 10;
  double maxZoom = 20.0;
  double minZoom = 10;
  double zoomLevel = 10.0;

  bool showMyLocation = false;
  bool isPressesLocation = false;
  bool isLocationActivated = false;

  @override
  void initState() {
    super.initState();

    logger.d("THIS IS FUNCKING TLIADSDSAASDF ${widget.isLoggedIn}");
  }

  _onMapCreated(MapboxMapController controller) async {
    setState(() {
      _mapController = controller;

      logger.d(_mapController != null);
    });
  }

  void _showAlert() {
    // logic forr the alert notif
    // setState(() {
    //   showMyLocation = !showMyLocation;
    // });
    // logger.d(showMyLocation);

    _onMapLocation();

    if (!isLocationActivated) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('This will be visible to other active users.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  logger.d(_mapController != null);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // _onMapLocation();
  }

  void _navigateToEmergencyContacts() {
    AutoRouter.of(context).push(const EmergencyContactsRouteRoute());
  }

  String? _getStyleKey() {
    String? style = "";
    Future.delayed(const Duration(milliseconds: 200), () async {
      style = await Config.getStyleKey();
      return style;
    });
    return null;
  }

  Future<bool> checkPermision(Permission permission) async {
    // final permission = Permission.locationAlways;
    final status = await permission.request();
    if (status.isGranted) {
      return true;
    } else if (status.isLimited) {
      return true;
    } else {
      return false;
    }
  }

  void _onMapLocation() {
    checkPermision(Permission.locationWhenInUse).then((value) async {
      if (Platform.isAndroid) {
        Location location = Location();
        bool isLocationEnabled = await location.serviceEnabled();

        if (!isLocationEnabled) {
          const intent = AndroidIntent(
              action: 'android.settings.LOCATION_SOURCE_SETTINGS');
          await intent.launch();
        }
      }
      logger.d(value);

      setState(() {
        _zoomLevel = zoomLevel.clamp(minZoom, maxZoom);
        showMyLocation = !showMyLocation;
        isPressesLocation = !isPressesLocation;

        if (isPressesLocation == true) {
          isLocationActivated = true;
        } else {
          isLocationActivated = false;
        }
      });
    });
  }

  void _locationUpdate(UserLocation userLocation) async {
    double lat = userLocation.position.latitude;
    double longi = userLocation.position.longitude;
    LatLng myLoc = LatLng(lat, longi);
    logger.d(myLoc);

    if (_mapController != null) {
      Point point = await _mapController!.toScreenLocation(myLoc);
      var radius = await _mapController!.getMetersPerPixelAtLatitude(lat);

      if (isPressesLocation && radius > 75) {
        await _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(LatLng(lat, longi), _zoomLevel));
      }
    }
    // Point points = await
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HikeMates',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(208, 72, 71, 71),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(
        isLogin: widget.isLoggedIn,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: _height,
            width: _width,
            child: MapboxMap(
              trackCameraPosition: true,
              styleString: _getStyleKey(),
              accessToken: const String.fromEnvironment('ACCESS_TOKEN'),
              initialCameraPosition: MapCameraPositions.kInitialCameraPostion,
              compassEnabled: false,
              attributionButtonMargins: const Point<num>(-100, -100),
              compassViewPosition: CompassViewPosition.TopRight,
              onMapCreated: _onMapCreated,
              myLocationEnabled: showMyLocation,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
              onUserLocationUpdated: _locationUpdate,
              myLocationRenderMode: MyLocationRenderMode.NORMAL,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
                  child: SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 250, 181, 34),
                          fixedSize: Size(52, 52),
                          padding: EdgeInsets.all(1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: _showAlert,
                      child: const Icon(Icons.crisis_alert),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 45, 101, 234),
                        fixedSize: Size(52, 52),
                        padding: EdgeInsets.all(1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: _navigateToEmergencyContacts,
                    child: const Icon(Icons.phone),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
