import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';

class AddressesListScreen extends StatefulWidget {
  const AddressesListScreen({Key? key}) : super(key: key);

  @override
  State<AddressesListScreen> createState() => _AddressesListScreenState();
}

class _AddressesListScreenState extends State<AddressesListScreen> {
  var arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Do Not Call',
          isBack: true,
          button1: arguments != null && arguments['showReassign'] != null
              ? "Re-Assign"
              : "",
          buttonTap1: arguments != null && arguments['showReassign'] != null
              ? () {
                  //  open contact screen
                  Get.toNamed(Routes.contactPage);
                }
              : () {},
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
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return doNotCallListTile(
                      dateTime: DateTime.now(),
                      location:
                          '2006 Chapmans Lane, San Francisc 2006 Chapmans Lane, San Franciscoo…',
                      leadingIconPath: Images.locationIcon,
                    );
                  }))
        ]));
  }

  doNotCallListTile({
    required DateTime dateTime,
    required String location,
    required String leadingIconPath,
  }) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.filedServiceMapPageScreen);

      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ImageView(
                path: leadingIconPath,
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
                    location,
                    style: w300_13(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy').format(dateTime),
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
