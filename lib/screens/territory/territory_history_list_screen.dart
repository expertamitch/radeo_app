import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/territory/controller/territory_controller.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/tiles/territory_history_tile.dart';

import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';

class TerritoryHistoryListScreen extends StatefulWidget {
  @override
  _TerritoryHistoryListScreenState createState() =>
      _TerritoryHistoryListScreenState();
}

class _TerritoryHistoryListScreenState
    extends State<TerritoryHistoryListScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TerritoryController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      controller.getTerritoryHistory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'History',
          isBack: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => controller.territoryHistoryLoading.value
                  ? OnScreenLoader()
                  : controller.territoryHistoryList.value.isEmpty
                      ? NotFoundWidget(
                          title: 'No territory history found',
                        )
                      : ListView.builder(
                          itemCount:
                              controller.territoryHistoryList.value.length,
                          itemBuilder: (context, index) {
                            return TerritoryHistoryTile(
                              info:
                                  controller.territoryHistoryList.value[index],
                            );
                          })),
            ),
          ],
        ));
  }
}
