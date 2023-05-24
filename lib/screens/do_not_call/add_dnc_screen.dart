import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/image_view.dart';

class AddDncScreen extends StatefulWidget {
  @override
  _AddDncScreenState createState() => _AddDncScreenState();
}

class _AddDncScreenState extends State<AddDncScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Add DNC',
        isBack: true,

        button1: 'Save',
        buttonTap1: (){Get.back();},
      ),
      body: Container(
        padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),

        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightGreyColor),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: SizedBox(),
                value: "Territory 1",
                icon: ImageView(
                  path: Images.downArrowIcon,
                ),
                hint: Text(
                  'Select',
                  style: w300_13(),
                ),
                items: <String>[
                  'Territory 1',
                  'Territory 2',
                  'Territory 3',
                  'Territory 4'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: w300_13(),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              style: w300_12(),
              decoration: InputDecoration(
                  hintStyle: w300_12(
                    color: AppColors.dark2GreyColor,
                  ),
                  hintText: 'Address',
                  fillColor: AppColors.lightGreyColor,
                  filled: true,
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor))),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter address' : null,
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              style: w300_12(),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(
                  hintStyle: w300_12(
                    color: AppColors.dark2GreyColor,
                  ),
                  hintText: 'Reason',
                  fillColor: AppColors.lightGreyColor,
                  filled: true,
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor))),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
              value == null || value.isEmpty ? 'Please enter reason' : null,
            ),
          ],
        ),
      ),
    );
  }
}
