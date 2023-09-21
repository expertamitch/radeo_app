import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/do_not_call/controller/dnc_controller.dart';
import 'package:redeo/utils/snackbar_util.dart';
import 'package:redeo/widgets/loader.dart';

import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/image_view.dart';

class AddDncScreen extends StatefulWidget {
  @override
  _AddDncScreenState createState() => _AddDncScreenState();
}

class _AddDncScreenState extends State<AddDncScreen> {
  DNCController controller = Get.find();

  String? selectedTerritory;
  String? selectedAddress;
  String? reason;

  RxBool isDisabled = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'Add DNC',
            isBack: true,
            button1Disabled: isDisabled.value,
            button1: 'Save',
            buttonTap1: () async {
              if (!isDisabled.value) {
                String? message = await controller.addDNC(
                    territoryId: controller.territoryList.value
                        .lastWhere(
                            (element) => element.name == selectedTerritory)
                        .id!
                        .toString(),
                    address: selectedAddress!,
                    reason: reason!);

                if (message!=null) {
                  Get.back();
                  showSuccessSnackBar(message);
                }
              }
            },
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightGreyColor),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: SizedBox(),
                    value: selectedTerritory,
                    icon: ImageView(
                      path: Images.downArrowIcon,
                    ),
                    hint: Text(
                      'Select Territory',
                      style: w300_13(),
                    ),
                    items: controller.territoryList.value
                        .map((e) => e.name!)
                        .toList()
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: w300_13(),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) async {
                      selectedTerritory = val;
                      selectedAddress = null;
                      showLoader();
                      await controller.getTerritoryDetail(controller
                          .territoryList.value
                          .lastWhere(
                              (element) => element.name == selectedTerritory)
                          .id!);
                      hideLoader();
                      checkValid();
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightGreyColor),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: SizedBox(),
                    value: selectedAddress,
                    icon: ImageView(
                      path: Images.downArrowIcon,
                    ),
                    hint: Text(
                      'Select Address',
                      style: w300_13(),
                    ),
                    items: controller.tempAddresses.value
                        .map((e) => e.fullAddress!)
                        .toList()
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: w300_13(),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      selectedAddress = val;
                      checkValid();

                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  style: w300_12(),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintStyle: w300_12(
                        color: AppColors.dark2GreyColor,
                      ),
                      hintText: 'Reason',
                      fillColor: AppColors.lightGreyColor,
                      filled: true,
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lightGreyColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lightGreyColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: AppColors.lightGreyColor))),
                  onChanged: (data) {
                    reason = data;
                    checkValid();
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter reason'
                      : null,
                ),
              ],
            ),
          ),
        ));
  }

  checkValid() {
    isDisabled.value = (selectedTerritory == null ||
        selectedAddress == null ||
        reason == null ||
        reason!.isEmpty);
  }
}
