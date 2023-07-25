import 'dart:io';

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../widgets/image_view.dart';
import '../../../route/routes.dart';
import '../../../utils/common_dialogs.dart';
import '../video_message/video_page.dart';

class SelectVideoMessagePage extends StatefulWidget {
  const SelectVideoMessagePage({Key? key}) : super(key: key);

  @override
  State<SelectVideoMessagePage> createState() => _SelectVideoMessagePageState();
}

class _SelectVideoMessagePageState extends State<SelectVideoMessagePage> {
  TextEditingController searchController = TextEditingController();

  MessageController controller = Get.find();

  int? selectedVideoIndex;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
                centerTitle: 'Select Video',
                textStyle: w600_14(),
                centerTitleStyle: w900_16(),
                backIcon: Platform.isAndroid ? Icons.arrow_back_outlined : null,
                onChanged: (text) {
                  setState(() {});
                },
                searchTextEditingController: searchController,
                horizontalPadding: 5),
          ))),
      body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            GestureDetector(
              onTap: () async {
                //camera permission
                var cameraStatus = await Permission.camera.request();
                if (cameraStatus.isGranted) {
                } else if (cameraStatus ==
                    PermissionStatus.permanentlyDenied) {
                  showConfirmationDialog(context,
                      "You have denied camera permission. To create new video, you need to allow permission. Press Yes to open settings and allow permission.",
                      yesCallback: () async {
                    Get.back();
                    await openAppSettings();
                  });
                }

                var audioStatus = await Permission.microphone.request();
                if (audioStatus.isGranted) {
                } else if (audioStatus ==
                    PermissionStatus.permanentlyDenied) {
                  showConfirmationDialog(context,
                      "You have denied microphone permission. To create new video, you need to allow permission. Press Yes to open settings and allow permission.",
                      yesCallback: () async {
                    Get.back();
                    await openAppSettings();
                  });
                }

                var camera = await Permission.camera.status;
                var audio = await Permission.microphone.status;
                if (camera.isGranted && audio.isGranted) {
                  XFile? pickedFile = await ImagePicker().pickVideo(
                      source: ImageSource.camera,

                  );
                  if (pickedFile != null) {
                    var file = File(pickedFile.path);

                    final route = MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (_) => VideoPage(filePath: file.path),
                    );
                    Navigator.push(context, route).then((value) {
                      if (value != null) Get.back(result: value);
                    });


                    // Get.back(result: file);
                  }


                  // Get.toNamed(Routes.recordVideoMessageScreen)
                  //     ?.then((value) {
                  //   if (value != null && value is int) {
                  //     Get.back(result: value);
                  //   }
                  // });
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
                          path: Images.videoIcon,
                          height: 16,
                          color: AppColors.purpleColor,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'Create New Video',
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
                      color: AppColors.greyColor,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            if (isLoading)
              Center(
                  child: SizedBox(
                width: 30.w,
                height: 30.h,
                child: CircularProgressIndicator(
                  color: AppColors.purpleColor,
                ),
              )),

                Obx(() => Expanded(
                  child: ListView.builder(itemBuilder: (c,i){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          Get.back(
                              result: controller
                                  .videoMessageList.value
                                  .elementAt(i)
                                  .id);
                        });

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
                                    ImageView(
                                      path: controller
                                          .videoMessageList.value
                                          .elementAt(i)
                                          .thumbnail!,
                                      height: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.26,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.27,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller
                                            .videoMessageList.value
                                            .elementAt(i)
                                            .title!,
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
                                launchUrl(Uri.parse(controller
                                    .videoMessageList.value
                                    .elementAt(i)
                                    .file!));
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
                                    context, "Do you want to delete this video?",
                                    yesCallback: () async {
                                      Get.back();
                                      controller.deleteVideoMessage(controller
                                          .videoMessageList.value
                                          .elementAt(i)
                                          .id!);
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
                  },itemCount: controller.videoMessageList.value.length),
                )),
//                 Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width.w,
//                       child: Wrap(
//                           alignment:
//                               controller.videoMessageList.value.length == 2
//                                   ? WrapAlignment.start
//                                   : WrapAlignment.spaceBetween,
//                           crossAxisAlignment: WrapCrossAlignment.center,
//                           runAlignment:
//                               controller.videoMessageList.value.length == 2
//                                   ? WrapAlignment.start
//                                   : WrapAlignment.spaceBetween,
//                           runSpacing: 10,
//                           spacing: 10,
//                           children: List.generate(
//                               controller.videoMessageList.value.length,
//                               (index) => GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         Get.back(
//                                             result: controller
//                                                 .videoMessageList.value
//                                                 .elementAt(index)
//                                                 .id);
//                                       });
//                                     },
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.27,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Stack(
//                                             children: [
//                                               ImageView(
//                                                 path: controller
//                                                     .videoMessageList.value
//                                                     .elementAt(index)
//                                                     .thumbnail!,
//                                                 height: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.26,
//                                                 fit: BoxFit.cover,
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.27,
//                                               ),
//                                               if (selectedVideoIndex == index)
//                                                 Container(
//                                                   color: AppColors.purpleColor
//                                                       .withOpacity(.38),
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.26,
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.27,
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       ImageView(
//                                                         path: Images.selectIcon,
//                                                         width: 25,
//                                                         height: 25,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               Positioned(
//                                                 bottom: 5,
//                                                 left: 10,
//                                                 child: ImageView(
//                                                   path: Images.videoIcon,
//                                                   color: Colors.white,
//                                                   width: 15,
//                                                   height: 15,
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 bottom: 0,
//                                                 right: 0,
//                                                 child: GestureDetector(
//                                                   onTap: () {
//                                                     showConfirmationDialog(
//                                                         context, "Do you want to delete this video?",
//                                                         yesCallback: () async {
//                                                           Get.back();
//                                                           controller.deleteAudioMessage(controller
//                                                               .videoMessageList.value
//                                                               .elementAt(index).id!);
//                                                         });
//                                                   },
//                                                   child: Container(
//                                                     color: Colors.transparent,
// padding: EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 5),
//                                                     child: Row(
//                                                       mainAxisAlignment: MainAxisAlignment.center,
//                                                       children: [
//                                                         ImageView(
//                                                           path: Images.deleteIcon,
//                                                           height: 15.h,
//                                                           color: Colors.white,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10.h,
//                                           ),
//                                           Text(
//                                             controller.videoMessageList
//                                                     .value[index].title ??
//                                                 '',
//                                             style: w300_13(),
//                                             overflow: TextOverflow.ellipsis,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ))),
//                     )),
          ])),
    );
  }
}
