import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/models/dnc_list_response_model.dart';
import 'package:redeo/models/territory_detail_model.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/do_not_call/controller/dnc_controller.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';
import '../../widgets/search_widget.dart';

class AddressesListScreen extends StatefulWidget {
  const AddressesListScreen({Key? key}) : super(key: key);

  @override
  State<AddressesListScreen> createState() => _AddressesListScreenState();
}

class _AddressesListScreenState extends State<AddressesListScreen> {
  var arguments = Get.arguments;

  DNCController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200))
        .then((value) => controller.getTerritoryDetail(arguments));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Do Not Call',
          isBack: true,


        ),
        body: Obx(() => Column(children: [
          !controller.dncListLoading.value?SearchWidget(
            hint: 'Search Address...',
            onChange: controller.executeSearch,
          ):Container(),
          Expanded(
              child: controller.dncListLoading.value
                  ? OnScreenLoader()
                  : controller.tempDncList.value.isEmpty
                  ? Center(
                child: SingleChildScrollView(child: NotFoundWidget(
                  title: 'No addresses found',
                ),),
              )
                  : ListView.builder(
                  itemCount: controller
                      .tempDncList.value.length,
                  itemBuilder: (context, index) {
                    return doNotCallListTile(
                        controller
                            .tempDncList.value[index],



                    );
                  }))
        ])));
  }

  doNotCallListTile(DoNotCalls model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.filedServiceMapPageScreen);
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ImageView(
                path: Images.locationIcon,
                color: AppColors.purpleColor,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.address??'',
                    style: w300_13(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy').format(model.createdAt! ),
                        style: w300_13(color: Colors.grey),
                      ),

                      Text(
                        'Do Not Call',
                        style: w300_13(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
