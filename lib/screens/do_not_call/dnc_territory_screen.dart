import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/models/territory_list_model.dart';
import 'package:redeo/network/repository/backend_repo.dart';
import 'package:redeo/screens/do_not_call/controller/dnc_controller.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class DNCTerritoryScreen extends StatefulWidget {
  const DNCTerritoryScreen({Key? key}) : super(key: key);

  @override
  State<DNCTerritoryScreen> createState() => _DNCTerritoryScreenState();
}

class _DNCTerritoryScreenState extends State<DNCTerritoryScreen> {
  DNCController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Do Not Call',
          isBack: Get.arguments != null,
          button1: 'Add DNC',
          buttonTap1: () {
            Get.toNamed(Routes.addDncScreen);
          },

        ),
        body: Obx(() => controller.territoryListLoading.value
            ? OnScreenLoader()
            : controller.territoryList.value.isEmpty
                ? NotFoundWidget(
                    title: 'No territories found',
                  )
                : ListView.builder(
                    itemCount: controller.territoryList.length,
                    itemBuilder: (context, index) {
                      return territoryTile(controller.territoryList[index]);
                    })));
  }

  territoryTile(TerritoryInfo model) {
    return GestureDetector(
      onTap: () {
        controller.addresses.clear();
        controller.tempAddresses.clear();
        controller.getDNCList(model.id!);
        Get.toNamed(Routes.listOfAddressScreen, arguments: model.id!);
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageView(
              path: BackendRepo.storageUrl + model.image!,
              fit: BoxFit.cover,
              height: 30.sp,
              width: 30.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              child: Text(
                model.name ?? '',
                style: w300_13(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
