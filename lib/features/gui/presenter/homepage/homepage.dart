// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element, unused_field

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:android_intent_plus/android_intent.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hike_mates/common/app_module.dart';
import 'package:hike_mates/features/domain/entity/login_entity.dart';
import 'package:hike_mates/features/domain/parameters/hike_code_params.dart';
import 'package:hike_mates/features/domain/parameters/user_location_params.dart';
import 'package:hike_mates/features/gui/constants/map_camera_position.dart';
import 'package:hike_mates/features/gui/constants/string_random.dart';
import 'package:hike_mates/features/gui/controllers/map_string_controller.dart';
import 'package:hike_mates/features/gui/presenter/homepage/home_page_bloc.dart';
import 'package:hike_mates/features/gui/ui/widget/custo_alert_dialog.dart';
import 'package:hike_mates/features/gui/ui/widget/generate_share_code.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';
import 'package:hike_mates/features/gui/ui/drawer/drawer.dart';
// import 'package:hike_mates/features/gui/ui/drawer/emergency_contacts.dart';
import 'package:hike_mates/features/gui/ui/routers/app_router.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  final int userId;
  final String? hikeCode;
  final LoginEntity loginEntity;

  const HomePage(this.userId, this.loginEntity, {this.hikeCode, Key? key})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _homeBloc = getIt<HomePageBloc>();
  final logger = Logger();
  MapboxMapController? _mapController;
  double _zoomLevel = 10;
  double maxZoom = 20.0;
  double minZoom = 10;
  double zoomLevel = 10.0;

  bool showMyLocation = false;
  bool isPressesLocation = false;
  bool isLocationActivated = false;
  bool isButtonEnabled = false;
  bool isGenerated = false;
  bool isEnterCode = false;
  double lat = 0.0;
  double lng = 0.0;

  List<Map<String, dynamic>> data = [];
  Set<dynamic> existingUserIds = {};

  List<LatLng> locatS = [];

  late String generateHikeCode;
  final TextEditingController inputCode = TextEditingController();
  Timer? _timer;
  Timer? _timerRefresh;
  final StringRandom _stringRandom = StringRandom();

  final TextEditingController hikeCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputCode.addListener(_validateInput);
    String? hikeCode = widget.hikeCode;

    // logger.d(hikeCode);
    setState(() {
      if (hikeCode != null) {
        generateHikeCode = hikeCode;
      }
    });
    _timerRefresh = Timer.periodic(const Duration(seconds: 2), (timer) {
      _refreshData();
    });
  }

  @override
  void dispose() {
    inputCode.dispose();
    _timer?.cancel();
    _timerRefresh?.cancel();

    super.dispose();
  }

  void _refreshData() {
    _homeBloc.add(CheckUserLocationEvent(
        CheckHikeUserParams(widget.userId, hikeCode: generateHikeCode)));
  }

  void _showAlert() {
    if (!isLocationActivated) {
      showDialog(
          context: context,
          builder: (BuildContext context) => StatefulBuilder(
                builder: (context, setState) {
                  return CustomAlertDialog(
                    height: 100,
                    colorMessage: Colors.orange,
                    title: "Alert",
                    actionOkayVisibility: true,
                    actionLabel: "Activate",
                    onPressOkay: _onPressedActivate,
                    onPressedCloseBtn: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                        "This will be visible to other active users if you share the code with them."),
                  );
                },
              ));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => StatefulBuilder(
                builder: (context, setState) {
                  return CustomAlertDialog(
                    height: 100,
                    colorMessage: Colors.orange,
                    title: "Alert",
                    actionOkayVisibility: true,
                    actionLabel: "Deactivate",
                    onPressOkay: _onPressedActivate,
                    onPressedCloseBtn: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Are you sure you want to disable this?"),
                  );
                },
              ));
    }

    // _onMapLocation();
  }

  void _showGenerateCode() {
    // logger.d(generateHikeCode.length);
    if (generateHikeCode.length != 4) {
      // generateHikeCode = "Hike Code";
      isGenerated = false;
      isEnterCode = false;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(builder: (context, setState) {
                return GenerateShareCodeWidget(
                  generateHikeCode,
                  controller: inputCode,
                  isGenerated: isGenerated,
                  submitFunction: _submitCode,
                  isEnterCode: isEnterCode,
                  generateCardFunction: () => _generateCodeFunction(setState),
                  enterCodeFunction: () => _enterCodeFunction(setState),
                );
              }));
    } else {
      // _submitCode();

      _showAlert();
    }
  }

  void _generateCodeFunction(StateSetter setState) {
    int elapsedTime = 0;

    Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      elapsedTime += 200;

      if (elapsedTime >= 3000) {
        timer.cancel();
        _timer = null;
        setState(() {
          isGenerated = true;
          isEnterCode = false;
        });
      } else {
        setState(() {
          // If less than 3 seconds have elapsed, continue with the normal functionality
          String code = _stringRandom.getRandomString(4);
          Future.delayed(const Duration(milliseconds: 1000));
          generateHikeCode = code;
          isGenerated = false;
          isEnterCode = false;
        });
      }
    });
  }

  void _enterCodeFunction(StateSetter setState) {
    setState(() {
      isEnterCode = true;
    });
  }

  void _submitCode() {
    // logger.d(inputCode.text);
    // logger.d(generateHikeCode);
    if (generateHikeCode == "Hike Code" && inputCode.text == "") {
      showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
                colorMessage: Colors.red,
                title: "Error",
                onPressedCloseBtn: () {
                  Navigator.pop(context);
                },
                child: const Text(
                    "Generate your code first or enter you Hike mate's code"));
          });
    }

    if (generateHikeCode != "Hike Code" && inputCode.text == "") {
      _homeBloc
          .add(SaveHikeCodeEvent(params: HikeCodeParams(generateHikeCode)));
      Navigator.pop(context);
    }

    if (generateHikeCode != "Hike Code" && inputCode.text != "") {
      _homeBloc
          .add(SaveHikeCodeEvent(params: HikeCodeParams(generateHikeCode)));
      Navigator.pop(context);
    }
  }

  void _navigateToEmergencyContacts() {
    AutoRouter.of(context)
        .push(EmergencyContactsRouteRoute(userId: widget.loginEntity.userId!));

    // UserLocationParams params = UserLocationParams(
    //     lati: "232324234234",
    //     longi: "234234234234",
    //     hikeCode: generateHikeCode,
    //     userId: widget.userId);

    // // logger.d(params);
    // _homeBloc.add(SaveUserLocationEvent(params));
  }

  String? _getStyleKey() {
    String? style = "";
    Future.delayed(const Duration(milliseconds: 200), () async {
      style = await Config.getStyleKey();
      return style;
    });
    return null;
  }

  void _validateInput() {
    setState(() {
      generateHikeCode = inputCode.text;
    });
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
      // logger.d(value);

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

    // logger.d(myLoc);

    if (_mapController != null) {
      // ignore: unused_local_variable
      Point point = await _mapController!.toScreenLocation(myLoc);
      var radius = await _mapController!.getMetersPerPixelAtLatitude(lat);

      if (isPressesLocation && radius > 75) {
        await _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(LatLng(lat, longi), _zoomLevel));
      }

      UserLocationParams params = UserLocationParams(
          lati: lat.toString(),
          longi: longi.toString(),
          hikeCode: generateHikeCode,
          userId: widget.userId);

      // logger.d(params);
      _homeBloc.add(SaveUserLocationEvent(params));
    }
    // Point points = await

    await myAsyncFunction();
  }

  Future<void> myAsyncFunction() async {
    // logger.e('Starting...');
    await Future.delayed(const Duration(milliseconds: 2000));
    // logger.e('Function completed.');
  }

  void _onPressedActivate() {
    _onMapLocation();
    Navigator.pop(context);
  }

  void addMarkers() async {
    for (LatLng location in locatS) {
      if (!_mapController!.symbols
          .any((symbol) => symbol.options.geometry == location)) {
        await _mapController!.addSymbol(
          SymbolOptions(
            geometry: location,
            iconImage: "assets/marker.png",
            iconSize: 1.5,
          ),
        );
        // logger.f("HELLO");
      }
    }
  }

  _onMapCreated(MapboxMapController controller) async {
    setState(() {
      _mapController = controller;
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        addMarkers();
      });
      // addMarkers();
    });

    // await _mapController!.addSymbol(
    //   SymbolOptions(
    //     iconSize: 0.3,
    //     iconImage: "marker",
    //     geometry: locat[0],
    //     iconAnchor: "bottom",
    //   ),
    // );
  }

  // Future<Uint8List> loadMarkerImage() async {
  //   var byteData = await rootBundle.load("assets/marker.png");
  //   return byteData.buffer.asUint8List();
  // }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return BlocConsumer<HomePageBloc, HomePageState>(
      bloc: _homeBloc,
      listener: (context, state) {
        // logger.d(state);
        if (state is HomeHikeCodeSuccessState) {
          setState(() {
            // logger.d(state.codeEntity.code);
            generateHikeCode == state.codeEntity.code;
            // logger.d(generateHikeCode);
          });
        }
        if (state is HomeSaveAllLocationState) {
          // logger.d(state.userLocationEntity);
          setState(() {
            for (var e in state.userLocationEntity) {
              // logger.d(e.lati);
              // logger.d(e.longi);
              if (!existingUserIds.contains(e.userId)) {
                existingUserIds.add(e.userId);

                var latLng = {
                  "lat": e.lati,
                  "longi": e.longi,
                  "userId": e.userId
                };

                LatLng latLngs = LatLng(
                    double.tryParse(e.lati!)!, double.tryParse(e.longi!)!);

                data.add(latLng);
                locatS.add(latLngs);
              }
            }
            // logger.e("THIS IS FUCKING ANNOYING $locatS");
          });
          addMarkers();
        }

        if (state is HomeLogoutState) {
          AutoRouter.of(context).replace(const LoginRoute());
        }
      },
      builder: (context, state) {
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
            widget.loginEntity,
            generateHikeCode,
            isLogin: true,
            logout: () {
              _homeBloc.add(LogoutEvent());
            },
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
                  initialCameraPosition:
                      MapCameraPositions.kInitialCameraPostion,
                  compassEnabled: false,
                  attributionButtonMargins: const Point<num>(-100, -100),
                  compassViewPosition: CompassViewPosition.TopRight,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: showMyLocation,
                  myLocationTrackingMode:
                      MyLocationTrackingMode.TrackingCompass,
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
                              fixedSize: const Size(52, 52),
                              padding: const EdgeInsets.all(1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          onPressed: _showGenerateCode, //_showAlert,
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
                            fixedSize: const Size(52, 52),
                            padding: const EdgeInsets.all(1),
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
      },
    );
  }
}
