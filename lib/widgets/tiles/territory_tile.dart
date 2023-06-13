import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/models/territory_list_model.dart';
import 'package:redeo/route/routes.dart';

import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../app_button.dart';
import '../image_view.dart';

class TerritoryTile extends StatelessWidget {
  TerritoryInfo info;

  TerritoryTile({required this.info});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.territoryDetailsScreen, arguments: info.id!);
        // if (index == 0)
        //   Get.toNamed(
        //     Routes.territoryDetailsScreen,
        //   );
        // else if (index == 1) {
        //   Get.toNamed(
        //     Routes.contactPage,
        //   );
        // }
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
              path: info.image??'',
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
                    info.name??'',
                    style: w600_14(),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  AppButton(
                      onPressedFunction: () {
                        /*  if (index == 0)
                          Get.toNamed(
                            Routes.listOfAddressScreen,
                          );
                        else if (index == 1) {
                          Get.toNamed(
                            Routes.contactPage,
                          );
                        }*/
                      },
                      child: Text(
                        // index == 0
                        //     ? "In use"
                        //     : index == 1
                        //     ? "Assign"
                        //     : "Completed",
                        'In use',
                        style: w300_13(color: Colors.white),
                      ),
                      height: 20.h,
                      sodiumShapeBorder: true,
                      width: null,
                      buttonColor: AppColors.purpleColor)
                ],
              ),
            ),
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
