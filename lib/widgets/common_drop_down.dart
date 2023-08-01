import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/images.dart';
import '../styling/app_colors.dart';
import '../styling/font_style_globle.dart';
import 'image_view.dart';

class CommonDropDown extends StatelessWidget{
  Function(String) onChanged;
  List<String> data;
  String hint;
  String? mainHint;
  String? value;


  CommonDropDown({required this.value, required this.data, required this.hint, this.mainHint,required this.onChanged});


  @override
  Widget build(BuildContext context) {
     return Column(      crossAxisAlignment: CrossAxisAlignment.start,

       children: [

         Text(
           hint,
           style: w300_13(
             color: AppColors.blueColor,
           ),
         ),
         SizedBox(height: 10.h,),
         Container(
           decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: AppColors.lightGreyColor),
           padding: EdgeInsets.symmetric(horizontal: 10),
           child: DropdownButton<String>(
             isExpanded: true,
             underline: SizedBox(),
             value: value,
             icon: ImageView(
               path: Images.downArrowIcon,
             ),
             hint: Text(
               mainHint??hint,
               style: w300_13(),
             ),
             items: data
                 .map((String value) {
               return DropdownMenuItem<String>(
                 value: value,
                 child: Text(
                   value,
                   style: w300_13(),
                 ),
               );
             }).toList(),
             onChanged: (val) {
               this.onChanged(val!);
             },
           ),
         ),
       ],
     );
  }



}