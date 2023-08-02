import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/models/return_visit_list_model.dart';
import 'package:redeo/screens/notice_of_event/notice_of_event_controller.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class ReturnVisitsPage extends StatefulWidget {
  const ReturnVisitsPage({Key? key}) : super(key: key);

  @override
  State<ReturnVisitsPage> createState() => _ReturnVisitsPageState();
}

class _ReturnVisitsPageState extends State<ReturnVisitsPage> {
  NoticeOfEventController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Return Visits',
        ),
        body: Obx(() => controller.noeListLoading.value
            ? OnScreenLoader()
            : controller.noeList.value.isEmpty
                ? NotFoundWidget(
                    title: 'No Returns found',
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: AppColors.greyColor),
                    itemCount: controller.noeList.length,
                    itemBuilder: (context, index) {
                      return historyListTile(controller.noeList[index]);
                    })));
  }

  historyListTile(NOEModel noeModel) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.returnDetailScreen, arguments: noeModel);
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMM d, yyyy | h:mm a')
                      .format(noeModel.returnVisit!.returnDate!),
                  style: w900_12(
                    color: AppColors.purpleColor,
                  ),
                ),
                SvgPicture.asset(
                  noeModel.returnVisit!.level == 'cloud'
                      ? 'assets/icons/screen 18/Level 1.svg'
                      : noeModel.returnVisit!.level == 'rain'
                          ? 'assets/icons/screen 18/Level 2.svg'
                          : 'assets/icons/screen 18/Level 3.svg',
                  height: 30,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              noeModel.name!,
              style: w600_16(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              noeModel.location!,
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
                noeModel.notes!,
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),

            /*Align(
              alignment: Alignment.topRight,
              child: Text(
                'Incomplete',
                style: w300_13(color: AppColors.redColor),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
