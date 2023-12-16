import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../assets/images.dart';
import '../../models/territory_detail_model.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../image_view.dart';

class TerritoryAddressTile extends StatelessWidget{

  Addresses address;
  TerritoryAddressTile({required this.address});
  @override
  Widget build(BuildContext context) {
return GestureDetector(
  onTap: () {
    Get.toNamed(Routes.filedServiceMapPageScreen,arguments: address.fullAddress);
  },
  child: Container(
    decoration: BoxDecoration(
        border:
        Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ImageView(
            path: Images.locationIcon,
            color: AppColors.purpleColor,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.fullAddress??'',
                style: w300_13(),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd MMM yyyy').format(address.createdAt! ),
                    style: w300_13(color: Colors.grey),
                  ),

                ],
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