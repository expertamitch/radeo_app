import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/screens/territory/controller/territory_controller.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';
import '../../widgets/tiles/territory_address_tile.dart';

class TerritoryDetailsScreen extends StatefulWidget {
  const TerritoryDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TerritoryDetailsScreen> createState() => _TerritoryDetailsScreenState();
}

class _TerritoryDetailsScreenState extends State<TerritoryDetailsScreen> {
  var id = Get.arguments;
  TerritoryController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100))
        .then((value) => controller.getTerritoryDetail("2"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Addresses',
          isBack: true,
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
        body: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                ImageView(
                  path: Images.searchIcon,
                  color: Colors.purple,
                ),
                SizedBox(width: 15.w),
                Flexible(
                    child: TextFormField(
                  style: w300_13(),
                  decoration: InputDecoration(
                      hintStyle: w300_13(
                        color: AppColors.dark2GreyColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Address...',
                      isDense: true),
                ))
              ],
            ),
          ),
          Expanded(
              child: Obx(() => controller.territoryDetailLoading.value
                  ? OnScreenLoader()
                  : controller.territoryList.value.isEmpty
                      ? NotFoundWidget(
                          title: 'No addresses found',
                        )
                      : ListView.builder(
                          itemCount: controller.addresses.value.length,
                          itemBuilder: (context, index) {
                            return TerritoryAddressTile(
                              address: controller.addresses.value[index],
                            );
                          })))
        ]));
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
