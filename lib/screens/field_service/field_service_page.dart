import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class FieldServicePage extends StatefulWidget {
  const FieldServicePage({Key? key}) : super(key: key);

  @override
  State<FieldServicePage> createState() => _FieldServicePageState();
}

class _FieldServicePageState extends State<FieldServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'Field Service',
              style: w900_30(),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return filedServiceListTile(
                      dateTime: DateTime.now(),
                      location:
                          '2006 Chapmans Lane, San Francisc 2006 Chapmans Lane, San Franciscoo…',
                      leadingIconPath: Images.locationIcon,
                    );
                  }))
        ]));
  }

  filedServiceListTile({
    required DateTime dateTime,
    required String location,
    required String leadingIconPath,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.filedServiceMapPageScreen);
        // FiledServiceMapPage
      },
      child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 30,
                    alignment: Alignment.centerLeft,
                    child: ImageView(
                      path: leadingIconPath,
                      color: AppColors.purpleColor,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      location,
                      style: w300_12(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 5),
                child: Text(
                  DateFormat('dd MMM yyyy').format(dateTime),
                  style: w300_10(color: AppColors.dark2GreyColor),
                ),
              ),
            ],
          )),
    );
  }
}
