import 'dart:io';

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redeo/models/custom_message_model.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../assets/images.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../utils/common_dialogs.dart';
import '../../../widgets/image_view.dart';

class SelectAudioMessage extends StatefulWidget {
  const SelectAudioMessage({Key? key}) : super(key: key);

  @override
  State<SelectAudioMessage> createState() => _SelectAudioMessageState();
}

class _SelectAudioMessageState extends State<SelectAudioMessage> {
  late TextEditingController searchController = TextEditingController();
  MessageController controller = Get.find();

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
            GestureDetector(
              onTap: () async {
                var status = await Permission.microphone.status;
                if (status.isGranted || Platform.isIOS) {
                  Get.toNamed(Routes.recordVoiceMessageScreen)?.then((value) {
                    if(value!=null && value is int){
                      Get.back(result: value);
                    }
                  });
                } else if (status == PermissionStatus.permanentlyDenied ||
                    status == PermissionStatus.denied) {
                  showConfirmationDialog(context,
                      "You have denied microphone permission. To record new audio, you need to allow permission. Press Yes to open settings and allow permission.",
                      yesCallback: () async {
                    Get.back();
                    await openAppSettings();
                    var check = await Permission.microphone.status;
                    if (check.isGranted)
                      Get.toNamed(Routes.recordVoiceMessageScreen)?.then((value) {
                        if(value!=null && value is int){
                          Get.back(result: value);
                        }
                      });
                  });
                } else {
                  var p = await Permission.microphone.request();
                  print(p);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
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
                        Text(
                          'Create New Audio',
                          style: w600_14(
                            color: AppColors.purpleColor,
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
                  ],
                ),
              ),
            ),
            Obx(() => Expanded(
                child: ListView.builder(
                    itemCount: controller.audioMessageList.value.length,
                    itemBuilder: (context, index) {
                      return audioListTile(
                        message: controller.audioMessageList.value[index],
                          title:
                              controller.audioMessageList.value[index].title ??
                                  '',
                          id: controller.audioMessageList.value[index].id);
                    })))
          ]),
        ));
  }

  audioListTile({
    required CustomMessage message,
    required String title,
    required int? id,
  }) {
    return GestureDetector(
      onTap: (){
        Get.back(result:  message.id);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Expanded(
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
                Expanded(
                  child: Text(
                    title,
                    style: w300_13(),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )),
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(message.file!));
              },
              child: Container(
                color: Colors.transparent,
                height: 40,
                width: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle,
                      size: 15.h,
                    ),
                  ],
                ),
              ),
            ),
              GestureDetector(
                onTap: () {
                  showConfirmationDialog(
                      context, "Do you want to delete this audio?",
                      yesCallback: () async {
                    Get.back();
                    controller.deleteAudioMessage(id!);
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  height: 40,
                  width: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageView(
                        path: Images.deleteIcon,
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
