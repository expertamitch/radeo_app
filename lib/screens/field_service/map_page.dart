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
              AppButton(
                  onPressedFunction: () {
                    Get.toNamed(Routes.createNoticeOfEventScreen);
                  },
                  child: Text(
                    'NOE',
                    style: w500_12(color: Colors.white),
                  ),
                  height: 40.h,
                  width: (MediaQuery.of(context).size.width * 0.28).w,
                  buttonColor: AppColors.purpleColor),
              AppButton(
                  onPressedFunction: () {
                    Get.toNamed(Routes.chatScreen);
                  },
                  child: Text(
                    'Message',
                    style: w500_12(color: Colors.white),
                  ),
                  height: 40.h,
                  width: (MediaQuery.of(context).size.width * 0.28).w,
                  buttonColor: AppColors.purpleColor),
              AppButton(
                  onPressedFunction: () {
                    Get.toNamed(Routes.doNotCallScreen);
                  },
                  child: Text(
                    'DNC',
                    style: w500_12(color: Colors.white),
                  ),
                  height: 40.h,
                  width: (MediaQuery.of(context).size.width * 0.28).w,
                  buttonColor: AppColors.purpleColor),
            ],
          ),
        ),
      ]),
    );
  }
}
