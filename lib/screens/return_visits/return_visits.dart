import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';

class ReturnVisitsPage extends StatefulWidget {
  const ReturnVisitsPage({Key? key}) : super(key: key);

  @override
  State<ReturnVisitsPage> createState() => _ReturnVisitsPageState();
}

class _ReturnVisitsPageState extends State<ReturnVisitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:CustomAppBar(
          title: 'Return Visits',

        ),
        body: Column(children: [

          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: AppColors.greyColor),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return historyListTile(
                      index: index,
                        noteString:
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et',
                        dateTime: DateTime.now(),
                        name: 'John Doe',
                        location: '2006 Chapmans Lane, San Francisco…',
                        trailingLevelPath: Images.level1Icon);
                  }))
        ]));
  }

  historyListTile(
      {required DateTime dateTime,
        required int index,
      required String name,
      required String location,
      required String trailingLevelPath,
      required String noteString}) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.noticeOfEventSummaryScreen);

      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMM d, yyyy | h:mm a').format(dateTime),
                  style: w900_12(
                    color: AppColors.purpleColor,
                  ),
                ),
                SvgPicture.asset(
                  trailingLevelPath,
                  height: 30,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              name,
              style: w600_16(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              location,
              style: w300_13(color: AppColors.dark2GreyColor),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.all(10),
              child: Text(
                noteString,
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            if(index==1)
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'Incomplete',
                style: w300_13(color: AppColors.redColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
