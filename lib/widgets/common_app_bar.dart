import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/app_colors.dart';

import '../screens/home/home_page_controller.dart';
import '../styling/font_style_globle.dart';
import 'app_button.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String title;
  bool isBack;

  String? button1, button2;
  VoidCallback? buttonTap1, buttonTap2, backPress;
  Widget? button1Widget;
  bool button1Disabled;

  CustomAppBar(
      {Key? key,
      required this.title,
      this.isBack = false,
      this.button1,
      this.button1Disabled=false,
      this.backPress,
        this.button1Widget,
      this.button2,
      this.buttonTap1,
      this.buttonTap2})
      : preferredSize = Size.fromHeight(100.h),
        super(key: key);

  @override
  final Size preferredSize; // default

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  HomePageController homePageController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGreyColor,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: kToolbarHeight * 0.6,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.isBack
                  ? IconButton(
                      onPressed: widget.backPress ??
                          () {
                            Get.back();
                          },
                      icon: Icon(Icons.keyboard_backspace))
                  : IconButton(
                      onPressed: () {
                        homePageController.openDrawer();
                      },
                      icon: Icon(Icons.menu)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if ((widget.button1 != null && widget.button1!.isNotEmpty) || widget.button1Widget!=null)
                    AppButton(
                        onPressedFunction: widget.buttonTap1!,
                        child: widget.button1Widget??Text(
                          widget.button1!,
                          style: w300_12(color: Colors.white),
                        ),
                        height: 30.h,
                        sodiumShapeBorder: true,
                        width: null,
                        margin: EdgeInsets.only(right: 10.w),
                        buttonColor:
                        widget.button1Disabled ? Colors.black26:AppColors.purpleColor),
                  if (widget.button2 != null && widget.button2!.isNotEmpty)
                    AppButton(
                        onPressedFunction: widget.buttonTap2!,
                        child: Text(
                          widget.button2!,
                          style: w300_13(color: Colors.white),
                        ),
                        margin: EdgeInsets.only(right: 10.w),
                        height: 30.h,
                        sodiumShapeBorder: true,
                        width: null,
                        buttonColor: AppColors.blueColor),
                ],
              ),
            ],
          ),
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, top: 4.h),
            child: Text(
              widget.title,
              style: w900_30(),
            ),
          ),
        ],
      ),
    );
  }
}
