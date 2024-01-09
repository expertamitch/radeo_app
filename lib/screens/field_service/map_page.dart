import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fl_geocoder/fl_geocoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redeo/screens/home/home_page_controller.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/loader.dart';

class FiledServiceMapPage extends StatefulWidget {
  const FiledServiceMapPage({Key? key}) : super(key: key);

  @override
  State<FiledServiceMapPage> createState() => _FiledServiceMapPageState();
}

class _FiledServiceMapPageState extends State<FiledServiceMapPage>
    with WidgetsBindingObserver {
  final geocoder = FlGeocoder('AIzaSyA3RgI5FNsff4VWoh_i4IXIODZWPFk8U2o');
  Location? destLocation;
  LatLng? currentLocation;
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition? _kGoogle;

  @override
  void initState() {
    super.initState();
    getLatLng(Get.arguments);

    WidgetsBinding.instance.addObserver(this);

    initialise();
  }

  // THIS is called whenever life cycle changed
  // void didChangeAppLifecycleState(AppLifecycleState state) async {
  //   if (state == AppLifecycleState.resumed) {
  //     var hasPermission = await Geolocator.checkPermission();
  //     if (hasPermission == LocationPermission.always ||
  //         hasPermission == LocationPermission.whileInUse) {
  //       initialise();
  //     }
  //   }
  // }

  initialise() async {
    await getUserLocation();
  }

  getLatLng(String address) async {
    var add = await geocoder.findAddressesFromAddress(
        'Jalandhar Bus Stand, Unnamed Road, Jawahar Nagar, Jalandhar, Punjab');
    if (add.length > 0) {
      destLocation = add[0].geometry.location;
      setState(() {});
    }
  }

  Future<void> getUserLocation() async {
    var hasPermission = await Geolocator.checkPermission();

    if (hasPermission == LocationPermission.denied ||
        hasPermission == LocationPermission.deniedForever ||
        hasPermission == LocationPermission.unableToDetermine) {
      LocationPermission permission = await Geolocator.requestPermission();
    } else {
      showLoader();
      Position location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation = LatLng(location.latitude, location.longitude);

Future.delayed(Duration(seconds: 0)).then((value) {

  _kGoogle = CameraPosition(
    target: currentLocation!,
    zoom: 14.4746,
  );
  setState(() {

  });
});



      setState(() {});
      hideLoader();
    }

    return;
  }

  void changeMapMode(GoogleMapController mapController) {
    getJsonFile(Images.mapStyle)
        .then((value) => setMapStyle(value, mapController));
  }

  //helper function
  void setMapStyle(String mapStyle, GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }

  //helper function
  Future<String> getJsonFile(String path) async {
    ByteData byte = await rootBundle.load(path);
    var list = byte.buffer.asUint8List(byte.offsetInBytes, byte.lengthInBytes);
    return utf8.decode(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Stack(
            children: [
              currentLocation == null
                  ?Container(color: Colors.white,)
                  : GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      onMapCreated: (gmapController) {
                        _controller.complete(gmapController);
                        Future.delayed(Duration(seconds: 1), () async {
                          gmapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(currentLocation!.latitude,
                                    currentLocation!.longitude),
                                zoom: 13.5,
                              ),
                            ),
                          );
                        });
                      },
                      initialCameraPosition: _kGoogle!,
                    ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_sharp)),
                ),
              )
            ],
          ),
        ),
        Container(

          margin: EdgeInsets.only(top: 8, bottom: 8),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 16,
            runSpacing: 8,
            children: [
              if (destLocation != null)
                SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          primary: AppColors.purpleColor),
                      onPressed: () {
                        MapsLauncher.launchCoordinates(
                            destLocation!.latitude, destLocation!.longitude);
                      },
                      child: Text(
                        'Get Direction',
                        style: w300_12(color: Colors.white),
                      ),
                    )),
              SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.purpleColor),
                    onPressed: () {
                      Get.toNamed(Routes.createNoticeOfEventScreen,
                          arguments: true);
                    },
                    child: Text(
                      'NOE',
                      style: w300_12(color: Colors.white),
                    ),
                  )),
              SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.purpleColor),
                    onPressed: () {
                      HomePageController homePageController = Get.find();
                      homePageController.currentSelectedIndex.value = 2;
                      Get.until((route) => route.isFirst);

                      Get.back();
                    },
                    child: Text(
                      'Message',
                      style: w300_12(color: Colors.white),
                    ),
                  )),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.28,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.purpleColor),
                    onPressed: () {
                      Get.toNamed(
                        Routes.listOfAddressScreen,
                      );
                    },
                    child: Text(
                      'DNC',
                      style: w300_12(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}
