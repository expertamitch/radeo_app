import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/screens/territory/controller/territory_controller.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../route/routes.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';
import '../../widgets/tiles/territory_tile.dart';

class TerritoryListScreen extends StatefulWidget {
  @override
  _TerritoryListScreenState createState() => _TerritoryListScreenState();
}

class _TerritoryListScreenState extends State<TerritoryListScreen> {
  TerritoryController controller = Get.isRegistered<TerritoryController>()
      ? Get.find<TerritoryController>()
      : Get.put(TerritoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Territories',
          button1Widget: ImageView(
            path: Images.historyIcon,
            color: Colors.white,
            height: 16,
          ),
          buttonTap1: () {
            Get.toNamed(Routes.territoryHistoryListScreen);
          },
        ),
        body: Obx(() => controller.territoryListLoading.value
            ? OnScreenLoader()
            : controller.territoryList.value.isEmpty
                ? NotFoundWidget(
                    title: 'No territories found',
                  )
                : ListView.builder(
                    itemCount: controller.territoryList.value.length,
                    itemBuilder: (context, index) {
                      return TerritoryTile(
                        info: controller.territoryList.value[index],
                      );
                    })));
  }
}
