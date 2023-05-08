import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import '../../widgets/colors.dart';
import '../../widgets/image_view.dart';

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
                height: 20,
              ),
            ),
            SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.purpleColor),
                    onPressed: () {},
                    child: Text(
                      'Send Event Invite',
                      style: w600_14(color: Colors.white),
                    ))),
            SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: AppColors.blueColor),
                    onPressed: () {},
                    child: Text(
                      'Send Message',
                      style: w600_14(color: Colors.white),
                    ))),
            SizedBox(
              height: 40,
            ),
          ]),
        ));
  }
}
