import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';

class DNCTerritoryScreen extends StatefulWidget {
  const DNCTerritoryScreen({Key? key}) : super(key: key);

  @override
  State<DNCTerritoryScreen> createState() => _DNCTerritoryScreenState();
}

class _DNCTerritoryScreenState extends State<DNCTerritoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Do Not Call',
          isBack: Get.arguments != null,

        ),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
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
      onTap: (){
        Get.toNamed(Routes.listOfAddressScreen, );

      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              path: Images.mapImage,
              height: 30.sp,
              width: 30.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              child: Text(
                'Territory ${index + 1}',
                style: w300_13(),
              ),
            ),
          ],
        ),
      ),
    );
  }

 }
