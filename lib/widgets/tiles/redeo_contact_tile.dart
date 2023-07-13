import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class RedeoContactTile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.symmetric(
         horizontal: 18,
         vertical: 10,
       ),
       decoration: BoxDecoration(
           border: Border(bottom: BorderSide(color: AppColors.greyColor))),
       child: Row(children: [
         SvgPicture.asset(
           Images.peopleIcon,
           height: 23,
         ),
         SizedBox(
           width: 15.w,
         ),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Redeo Name A',
               style: w300_12(),
             ),
             SizedBox(
               height: 4.h,
             ),
             Text(
               '34 Members',
               style: w300_10(
                 color: AppColors.dark2GreyColor,
               ),
             )
           ],
         ),
         Expanded(
           child: SizedBox(
             width: 5.w,
           ),
         ),
         Radio(
           value: false,
           groupValue: 'groupValue',
           onChanged: (value) {},
         )
       ]),
     );
  }

}