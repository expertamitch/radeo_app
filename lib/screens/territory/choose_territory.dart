import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';
import '../../widgets/tiles/territory_tile.dart';
import 'controller/territory_controller.dart';

class ChooseTerritory extends StatelessWidget {
  TerritoryController controller = Get.isRegistered<TerritoryController>()
      ? Get.find<TerritoryController>()
      : Get.put(TerritoryController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Choose territory',
          isBack: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => controller.territoryListLoading.value
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
                              onTap: () {
                                Get.back(
                                    result:
                                        controller.territoryList.value[index]);
                              },
                            );
                          })),
            ),
          ],
        ));
  }
}
