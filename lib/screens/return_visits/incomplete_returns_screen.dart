import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../notice_of_event/notice_of_event_controller.dart';
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

class IncompleteReturnsScreen extends StatefulWidget{

  @override
  _IncompleteReturnsScreenState createState()=> _IncompleteReturnsScreenState();

}


class _IncompleteReturnsScreenState extends State<IncompleteReturnsScreen>{

  NoticeOfEventController controller = Get.find();

  ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          if (controller.incompleteReturnVisitListModel?.info?.nextPageUrl != null) {
            isLoading = !isLoading;
            controller.getPaginatedIncompleteNOEList().then((value) => null);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          isBack: true,
          title: 'Incomplete Returns',

        ),
        body: Obx(() => controller.incompleteNoeListLoading.value
            ? OnScreenLoader()
            : controller.incompleteNoeList.value.isEmpty
            ? NotFoundWidget(
          title: 'No Returns found',
        )
            : ListView.separated(
            controller: _scrollController,
            separatorBuilder: (context, index) =>
                Divider(color: AppColors.greyColor),
            itemCount: controller.incompleteNoeList.length,
            itemBuilder: (context, index) {
              return historyListTile(controller.incompleteNoeList[index]);
            })));
  }

  historyListTile(NOEModel noeModel) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.incompleteReturnDetailScreen, arguments: noeModel);
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
                      .format(noeModel.returnVisits![0].returnDate!),
                  style: w900_12(
                    color: AppColors.purpleColor,
                  ),
                ),
                SvgPicture.asset(
                  noeModel.returnVisits![0]!.level == 'cloud'
                      ? 'assets/icons/screen 18/Level 1.svg'
                      : noeModel.returnVisits![0]!.level == 'rain'
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