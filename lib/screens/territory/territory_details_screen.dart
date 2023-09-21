import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/screens/territory/controller/territory_controller.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../../models/territory_list_model.dart';
import '../../network/storage_utils.dart';
import '../../route/routes.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';
import '../../widgets/search_widget.dart';
import '../../widgets/tiles/territory_address_tile.dart';

class TerritoryDetailsScreen extends StatefulWidget {
  const TerritoryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TerritoryDetailsScreen> createState() => _TerritoryDetailsScreenState();
}

class _TerritoryDetailsScreenState extends State<TerritoryDetailsScreen> {
  TerritoryInfo territoryInfo = Get.arguments;
  TerritoryController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then(
        (value) => controller.getTerritoryDetail(territoryInfo.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Addresses',
          isBack: true,
          button1: territoryInfo.status == 'completed' &&
                  territoryInfo.userId == int.parse(StorageUtils.getUid()!)
              ? 'Re-assign'
              : null,
          buttonTap1: territoryInfo.status == 'completed' &&
                  territoryInfo.userId == int.parse(StorageUtils.getUid()!)
              ? () {
                  Get.toNamed(
                    Routes.contactPage,
                  )?.then((value) async {
                    if (value != null) {
                      TerritoryController controller = Get.find();
                      var success = await controller.assignTerritory(
                          id: territoryInfo.id.toString(), assigned_to: value);

                      if (success) Get.back();
                    }
                  });
                }
              : null,
          /*button1: 'Add DNC',
          buttonTap1: (){
            Get.toNamed(Routes.addDncScreen);
          },
          button2: arguments != null && arguments['showReassign'] != null
              ? "Re-Assign"
              : "",
          buttonTap2: arguments != null && arguments['showReassign'] != null
              ? () {
                  //  open contact screen
                  Get.toNamed(Routes.contactPage);
                }
              : () {},*/
        ),
        body: Obx(() => Column(
          children: [
            if (controller.detailModel?.info?.assignedUser != null)
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 10.h, horizontal: 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Assigned to - ',
                          style: w600_13(),
                        ),
                        Text(
                          '${controller.detailModel?.info?.assignedUser?.firstName ?? ''} ${controller.detailModel?.info?.assignedUser?.lastName ?? ''}',
                          style: w900_16(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Assign date - ',
                          style: w600_13(),
                        ),
                        Text(
                          DateFormat('dd MMMM, yyyy').format(
                            controller
                                .detailModel!.info!.assignedOn!
                                .toLocal(),
                          ),
                          style: w900_16(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),



            !controller.territoryDetailLoading.value?SearchWidget(
              hint: 'Search Address...',
              onChange: controller.executeSearch,
            ):Container(),

            Expanded(child:   controller.territoryDetailLoading.value
                ? OnScreenLoader()
                : controller.tempAddresses.value.isEmpty
                ? Center(
                  child: SingleChildScrollView(child: NotFoundWidget(
              title: 'No addresses found',
            ),),
                )
                : ListView.builder(
                itemCount: controller
                    .tempAddresses.value.length,
                itemBuilder: (context, index) {
                  return TerritoryAddressTile(
                    address: controller
                        .tempAddresses.value[index],
                  );
                }))
          ],
        )));
  }

  String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
      ? bankAccountName
          .trim()
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';
}
