import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';

class TerritoryHistoryListScreen extends StatefulWidget {
  @override
  _TerritoryHistoryListScreenState createState() =>
      _TerritoryHistoryListScreenState();
}

class _TerritoryHistoryListScreenState
    extends State<TerritoryHistoryListScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'History',
          isBack: true,
        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return territoryTile(
                      index: index,
                    );
                  }))
        ]));
  }

  territoryTile({
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        if (index == 0)
          Get.toNamed(Routes.listOfAddressScreen,
              arguments: {'showReassign': true});
      },
      child: Container (
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageView(
              path: Images.mapImage,
              height: 30.sp,
              width: 30.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Territory ${index + 1}',
                    style: w600_14(),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Assigned at : 05 Jan 2022, 05:10 am',
                    style: w300_13(),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Completed at : 06 Jan 2022, 05:10 am',
                    style: w300_13(),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    'Completed by : Amit Kumar',
                    style: w300_13(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
