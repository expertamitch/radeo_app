import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/app_button.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';

class TerritoryListScreen extends StatefulWidget {
  @override
  _TerritoryListScreenState createState() => _TerritoryListScreenState();
}

class _TerritoryListScreenState extends State<TerritoryListScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Territories',
          button1Widget: ImageView(
            path: Images.historyIcon,
            color: Colors.white,
            height: 16,
          ),
          buttonTap1: () {
            Get.toNamed(Routes.territoryHistoryListScreen);
          },
        ),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return territoryTile(
                  index: index,
                  type: index == 0
                      ? "inuse"
                      : index == 1
                          ? "assign"
                          : "complete");
            }));
  }

  territoryTile({required int index, required String type}) {
    return GestureDetector(
      onTap: () {
        if (index == 0)
          Get.toNamed(
            Routes.listOfAddressScreen,
          );
        else if (index == 1) {
          Get.toNamed(
            Routes.contactPage,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              path: Images.mapImage,
              height: 30.sp,
              width: 30.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Territory ${index + 1}',
                    style: w600_14(),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  AppButton(
                      onPressedFunction: () {
                        if (index == 0)
                          Get.toNamed(
                            Routes.listOfAddressScreen,
                          );
                        else if (index == 1) {
                          Get.toNamed(
                            Routes.contactPage,
                          );
                        }

                      },
                      child: Text(
                        index == 0
                            ? "In use"
                            : index == 1
                                ? "Assign"
                                : "Completed",
                        style: w300_13(color: Colors.white),
                      ),
                      height: 20.h,
                      sodiumShapeBorder: true,
                      width: null,
                      buttonColor: AppColors.purpleColor)
                ],
              ),
            ),
            if (index == 0 || index == 1)
              Text(
                'My Territory',
                style: w300_10(color: AppColors.redColor),
              ),
          ],
        ),
      ),
    );
  }
}
