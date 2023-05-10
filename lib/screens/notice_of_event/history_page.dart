import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'History',
              style: w900_30(),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    if (index == 1)
                      return historyListTile(
                          noteString:
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et',
                          dateTime: DateTime.now(),
                          subTitle: '2006 Chapmans Lane, San Francisco…',
                          leadingIconPath: Images.locationIcon,
                          trailingLevelPath: Images.level1Icon);
                    return historyListTile(
                        dateTime: DateTime.now(),
                        subTitle: '2006 Chapmans Lane, San Francisco…',
                        leadingIconPath: Images.locationIcon,
                        trailingLevelPath: Images.level1Icon);
                  }))
        ]));
  }

  historyListTile(
      {required DateTime dateTime,
      required String subTitle,
      required String leadingIconPath,
      required String trailingLevelPath,
      String? noteString}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              ImageView(
                path: leadingIconPath,
                height: 20,
                color: AppColors.purpleColor,
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        DateFormat('h:mm a | EEEE, MMM d, yyyy')
                            .format(dateTime),
                        style: w300_13()),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(subTitle,
                        style: w300_12(
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              SvgPicture.asset(
                trailingLevelPath,
                height: 35,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          if (noteString != null)
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(4)),
              // margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                noteString,
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
            ),
        ],
      ),
    );
  }
}
