import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/models/return_visit_list_model.dart';
import 'package:redeo/screens/notice_of_event/notice_of_event_controller.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class ReturnHistoryPage extends StatefulWidget {
  const ReturnHistoryPage({Key? key}) : super(key: key);

  @override
  State<ReturnHistoryPage> createState() => _ReturnHistoryPageState();
}

class _ReturnHistoryPageState extends State<ReturnHistoryPage> {
  NoticeOfEventController controller = Get.find();
  RxList<ReturnVisit> list = RxList();
  NOEModel noeModel=Get.arguments as NOEModel;

  @override
  void initState() {
    controller
        .getReturnHistory((Get.arguments as NOEModel).id.toString())
        .then((value) {
      if (value != null) {
        list.value = value.returnVisits!;
      }
    });

    super.initState();
  }

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
          Obx(() => Expanded(
              child:
              controller.returnListLoading.value
                  ? OnScreenLoader()
                  : list.value.isEmpty
                  ? NotFoundWidget(
                title: 'No Returns found',
              ):ListView.builder(
                  itemCount: list.value.length,
                  itemBuilder: (context, index) {
                       return historyListTile(
                         model:list[index]
                          );

                  })))
        ]));
  }

  historyListTile(
      {required ReturnVisit model,}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              ImageView(
                path: Images.locationIcon,
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
                        DateFormat('EEEE, MMM d, yyyy | h:mm a').format(model.returnDate!),
                        style: w300_13()),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(noeModel.location!,
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
                model.level == 'cloud'
                    ? 'assets/icons/screen 18/Level 1.svg'
                    : model.level == 'rain'
                    ? 'assets/icons/screen 18/Level 2.svg'
                    : 'assets/icons/screen 18/Level 3.svg',
                height: 35,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          if (model.description != null)
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(4)),
              // margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              child: Text(
                model.description!,
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
            ),
        ],
      ),
    );
  }
}
