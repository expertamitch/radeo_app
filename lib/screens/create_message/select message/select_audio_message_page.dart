import 'dart:io';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import '../../../assets/images.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';

import '../../../widgets/image_view.dart';

class SelectAudioMessage extends StatefulWidget {
  const SelectAudioMessage({Key? key}) : super(key: key);

  @override
  State<SelectAudioMessage> createState() => _SelectAudioMessageState();
}

class _SelectAudioMessageState extends State<SelectAudioMessage> {
  late TextEditingController searchController=TextEditingController();
  MessageController controller=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkGreyColor,
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 65),
            child: SafeArea(
                child: Container(
              decoration: const BoxDecoration(
                color: AppColors.darkGreyColor,
              ),
              alignment: Alignment.center,
              child: AnimationSearchBar(
                  searchIconColor: AppColors.purpleColor,
                  backIconColor: Colors.black,
                  centerTitle: 'Select Audio',
                  textStyle: w600_14(),
                  centerTitleStyle: w900_16(),
                  backIcon:
                      Platform.isAndroid ? Icons.arrow_back_outlined : null,
                  onChanged: (text) {
                    setState(() {});
                  },
                  searchTextEditingController: searchController,
                  horizontalPadding: 5),
            ))),
        body: Container(
          color: Colors.white,
          child: Column(children: [
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  path: Images.micIcon,
                  height: 16,
                  color: AppColors.purpleColor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.recordVoiceMessageScreen);
                  },
                  child: Text(
                    'Create New Audio',
                    style: w600_14(
                      color: AppColors.purpleColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              color: AppColors.borderGreyColor,
              thickness: 1,
            ),
            Obx(() => Expanded(
                child: ListView.builder(
                    itemCount: controller.audioMessageList.value.length,
                    itemBuilder: (context, index) {
                      var name=controller.audioMessageList.value[index].file!.split('/');
                      var ac=name.last;
                      return audioListTile(
                          title: ac,
                          duration: '00:12',
                          size: '12 KB');
                    })))
          ]),
        ));
  }

  audioListTile({
    required String title,
    required String duration,
    required String size,
  }) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.w,
            ),
            SvgPicture.asset(
              Images.audiFileIcon,
              width: 30,
            ),
            SizedBox(
              width: 20.w,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: w300_13(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    duration + '  ' + size,
                    style: w300_10(color: AppColors.dark2GreyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
