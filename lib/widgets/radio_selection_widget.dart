import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styling/app_colors.dart';

class RadioSelectionWidget extends StatelessWidget{
  bool selected=false;

  RadioSelectionWidget({required this.selected});
  @override
  Widget build(BuildContext context) {
     return Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(50),
         border: Border.all(
             width: 2.sp, color: AppColors.blueColor),
       ),
       height: 18.w,
       width: 18.w,
       child: Center(
         child: Container(
             height: 10.w,
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                 color:selected? AppColors.blueColor:Colors.white),
             width: 10.w),
       ),
     );
  }

}