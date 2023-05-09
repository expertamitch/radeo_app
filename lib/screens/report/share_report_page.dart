import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeo/styling/app_colors.dart';
import '../../assets/images.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

class ShareReportsPage extends StatefulWidget {
  const ShareReportsPage({Key? key}) : super(key: key);

  @override
  State<ShareReportsPage> createState() => _ShareReportsPageState();
}

class _ShareReportsPageState extends State<ShareReportsPage> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            ImageView(
              path: Images.shareImageImg,
            ),
            Expanded(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            AppButton(
                onPressedFunction: () {},
                child: Text(
                  'Send Event Invite',
                  style: w600_14(color: Colors.white),
                ),
                height: 50.h,
                buttonColor: AppColors.purpleColor),
            SizedBox(
              height: 15.h,
            ),
            AppButton(
                onPressedFunction: () {},
                child: Text(
                  'Send Message',
                  style: w600_14(color: Colors.white),
                ),
                height: 50.h,
                buttonColor: AppColors.blueColor),
            SizedBox(
              height: 40.h,
            ),
          ]),
        ));
  }
}
