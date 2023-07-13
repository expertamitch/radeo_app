import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../assets/images.dart';
import '../../models/territory_list_model.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../image_view.dart';

class TerritoryHistoryTile extends StatelessWidget
{
  TerritoryInfo info;

  TerritoryHistoryTile({required this.info});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

          Get.toNamed(Routes.territoryDetailsScreen,
              arguments: info);
      },
      child: Container (
        decoration: BoxDecoration(
            border:
            Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              path: info.image ?? '',
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
                    info.name!,
                    style: w600_14(),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Assigned at : 05 Jan 2022, 05:10 am',
                    style: w300_13(),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Completed at : 06 Jan 2022, 05:10 am',
                    style: w300_13(),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Completed by : Amit Kumar',
                    style: w300_13(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}