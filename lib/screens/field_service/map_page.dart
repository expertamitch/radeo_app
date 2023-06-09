import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'package:redeo/widgets/app_button.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class FiledServiceMapPage extends StatefulWidget {
  const FiledServiceMapPage({Key? key}) : super(key: key);

  @override
  State<FiledServiceMapPage> createState() => _FiledServiceMapPageState();
}

class _FiledServiceMapPageState extends State<FiledServiceMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  center: LatLng(51.509364, -0.128928),
                  zoom: 9.2,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
                nonRotatedChildren: [
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution('OpenStreetMap contributors',
                          onTap: null),
                    ],
                  ),
                ],
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
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.28,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.purpleColor),
                    onPressed: () {
                      Get.toNamed(Routes.createNoticeOfEventScreen, arguments: true);
                    },
                    child: Text(
                      'NOE',
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
                      Get.toNamed(Routes.chatScreen, arguments: true);
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
                      Get.toNamed(Routes.listOfAddressScreen, );
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
