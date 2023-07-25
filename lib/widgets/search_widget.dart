import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../assets/images.dart';
import '../styling/app_colors.dart';
import '../styling/font_style_globle.dart';
import 'image_view.dart';

class SearchWidget extends StatelessWidget {
  String hint;
Function(String) onChange;


  SearchWidget({required this.hint, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.darkGreyColor,
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          ImageView(
            path: Images.searchIcon,
            color: Colors.purple,
          ),
          SizedBox(width: 15.w),
          Flexible(
              child: TextFormField(
            style: w300_13(),

            decoration: InputDecoration(
                hintStyle: w300_13(
                  color: AppColors.dark2GreyColor,
                ),
                border: InputBorder.none,
                hintText: hint,
                isDense: true),
                onChanged: onChange,
          ))
        ],
      ),
    );
  }
}
