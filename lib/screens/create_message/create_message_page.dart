import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/models/create_message_request_model.dart';
import 'package:redeo/models/custom_message_model.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/utils/snackbar_util.dart';
import 'package:redeo/utils/validators.dart';
import 'package:redeo/widgets/app_button.dart';
import 'package:redeo/widgets/attachment_widget.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/common_dialogs.dart';
import '../../widgets/common_app_bar.dart';

class CreateMessagePage extends StatefulWidget {
  const CreateMessagePage({Key? key}) : super(key: key);

  @override
  State<CreateMessagePage> createState() => _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  MessageController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Message',
        button1: 'Review',
        buttonTap1: () {
          bool cSelected = false;
          List<int> selectedId = [];
          controller.customMessageList.value.forEach((element) {
            if (element.isSelected) {
              cSelected = true;
               selectedId.add(element.id!);
            }
          });

          if (Validators.validateName(controller.locationController.text) !=
              null) {
            showErrorSnackBar('Please fill location.');
          } else if (controller.selectedMessageType == null ||
              controller.selectedMessageId == null) {
            showErrorSnackBar('Please select message');
          } else if (controller.qrResult.isEmpty) {
            showErrorSnackBar('Please scan QR code');
          } else if (controller.response &&
              controller.selectedResponseType == 'Custom' &&
              !cSelected) {
            showErrorSnackBar('Please select response');
          } else {
            CreateMessageRequestModel model = CreateMessageRequestModel();
            model.location = controller.locationController.text;
            model.qrResult = controller.qrResult;
            model.selectedMessageType = controller.selectedMessageType!;
            model.selectedMessageId = controller.selectedMessageId!;
            model.response = controller.response;
            if (controller.attachmentFile != null)
              model.attachmentFile = controller.attachmentFile;

            if (controller.response)
              model.selectedResponseType = controller.selectedResponseType;
            if (controller.response &&
                controller.selectedResponseType == 'Custom' &&
                cSelected) {
              model.selectedCustomResponseId = selectedId;
            }

            Get.toNamed(Routes.reviewMessageScreen, arguments: model);
          }
        },
      ),
      body: Column(children: [
        Expanded(
          child: Form(
            key: _formKey,

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: w300_13(
                            color: AppColors.blueColor,
                          ),
                        ),
                        TextFormField(
                          style: w300_13(),
                          autovalidateMode: AutovalidateMode.disabled,
                          controller: controller.locationController,
                          decoration: InputDecoration(
                              hintStyle: w300_13(),
                              hintText: 'Select Location',
                              border: InputBorder.none,
                              prefixIconConstraints:
                                  BoxConstraints(maxWidth: 20, minWidth: 20),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageView(
                                      path: Images.locationIcon,
                                      color: AppColors.purpleColor,
                                      height: 18,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  getMessage(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: AttachmentWidget(
                        hint: 'Attachment',
                        title: 'Select Files',
                        attachment: controller.attachmentFile,
                        filePickedCallback: (value) {
                          controller.attachmentFile = value;
                          setState(() {});
                        }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Response',
                              style: w300_13(
                                color: AppColors.blueColor,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.6,
                              child: CupertinoSwitch(
                                activeColor: AppColors.purpleColor,
                                value: controller.response,
                                onChanged: (value) {
                                  setState(() {
                                    controller.response = value;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        if (controller.response) getResponseWidget(),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColors.greyColor,
                    thickness: 1,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              'Associating QR Code',
                              style: w300_13(
                                color: AppColors.blueColor,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Center(
                              child: ImageView(
                                path: Images.scanQr,
                                width: 120.w,
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            AppButton(
                                onPressedFunction: () async {
                                /*  if(Platform.isIOS)
                                    {
                                      scan();
                                      return;
                                    }
            */
                                  var cameraStatus =
                                      await Permission.camera.request();
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

                                  var audioStatus =
                                      await Permission.microphone.request();
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
                                  if (camera.isGranted && audio.isGranted)
                                    scan();
                                },
                                child: Text(
                                  controller.qrResult.isNotEmpty
                                      ? "Re-Scan QR"
                                      : 'Scan QR',
                                  style: w900_15(color: Colors.white),
                                ),
                                height: 50.h,
                                buttonColor: AppColors.purpleColor),
                            SizedBox(
                              height: 20.h,
                            ),
                          ]))
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  scan(){
    Get.toNamed(Routes.qrScanner)?.then((value) {
      if (value != null) {
        setState(() {
          if (value
              .toString()
              .split('/')
              .last
              .indexOf('-') >
              0) {
            controller.qrResult =
                value.toString().split('/').last;
          } else {
            showErrorSnackBar('Invalid Redeo QR');
          }
          print(controller.qrResult);
        });
      }
    });
  }

  Widget getMessage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Message',
                style: w300_13(
                  color: AppColors.blueColor,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              getMessageTypeTab(),
              SizedBox(
                height: 10.h,
              ),
              getSelectedMessage(),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          color: AppColors.greyColor,
          thickness: 1,
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }

  Widget getMessageTypeTab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.selectTextMessageScreen)?.then((value) {
              if (value != null) {
                setState(() {
                  controller.selectedMessageType = 'Text';
                  controller.selectedMessageId = value;
                });
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: controller.selectedMessageType == 'Text'
                        ? AppColors.purpleColor
                        : AppColors.greyColor),
                borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width * 0.28,
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  path: Images.textFileIcon,
                  height: 13,
                  color: AppColors.purpleColor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Text',
                  style: w300_13(
                    color: controller.selectedMessageType == 'Text'
                        ? AppColors.purpleColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.selectAudioMessageScreen)?.then((value) {
              if (value != null) {
                setState(() {
                  controller.selectedMessageType = 'Audio';
                  controller.selectedMessageId = value;
                });
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: controller.selectedMessageType == 'Audio'
                        ? AppColors.purpleColor
                        : AppColors.greyColor),
                borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width * 0.28,
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  path: Images.audioIcon,
                  height: 13,
                  color: AppColors.purpleColor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Audio',
                  style: w300_13(
                    color: controller.selectedMessageType == 'Audio'
                        ? AppColors.purpleColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.selectVideoMessageScreen)?.then((value) {
              if (value != null) {
                setState(() {
                  controller.selectedMessageType = 'Video';
                  controller.selectedMessageId = value;
                });
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: controller.selectedMessageType == 'Video'
                        ? AppColors.purpleColor
                        : AppColors.greyColor),
                borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width * 0.28,
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageView(
                  path: Images.videoIcon,
                  height: 13,
                  color: AppColors.purpleColor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Video',
                  style: w300_13(
                    color: controller.selectedMessageType == 'Video'
                        ? AppColors.purpleColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getSelectedMessage() {
    return Column(
      children: [
        if (controller.selectedMessageType == 'Text')
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightGreyColor),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      controller.textMessageList.value
                              .lastWhere((element) =>
                                  element.id == controller.selectedMessageId)
                              .content ??
                          '',
                      style: w300_13(color: AppColors.dark2GreyColor),
                    ),
                  ),
                  getCloseIcon(),
                ],
              )),
        if (controller.selectedMessageType == 'Audio')
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.lightGreyColor),
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                SvgPicture.asset(
                  Images.audiFileIcon,
                  width: 30,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.audioMessageList.value
                              .lastWhere((element) =>
                                  element.id == controller.selectedMessageId)
                              .title ??
                          '',
                      style: w300_13(),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
                Expanded(
                    child: SizedBox(
                  width: 5,
                )),
                getCloseIcon()
              ],
            ),
          ),
        if (controller.selectedMessageType == 'Video')
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.lightGreyColor),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                ImageView(
                  path: (controller.videoMessageList.value
                          .lastWhere((element) =>
                              element.id == controller.selectedMessageId)
                          .thumbnail ??
                      ''),
                  height: 50,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.videoMessageList.value
                              .lastWhere((element) =>
                                  element.id == controller.selectedMessageId)
                              .title ??
                          '',
                      style: w300_13(),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
                Expanded(
                    child: SizedBox(
                  width: 5,
                )),
                getCloseIcon()
              ],
            ),
          ),
      ],
    );
  }

  Widget getCloseIcon() {
    return GestureDetector(
      onTap: () {
        controller.selectedMessageId = null;
        controller.selectedMessageType = null;
        setState(() {});
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(15),
        child: ImageView(
          path: Images.closeIcon,
          width: 15,
          color: AppColors.purpleColor,
        ),
      ),
    );
  }

  getResponseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  controller.selectedResponseType = 'Open';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: controller.selectedResponseType == 'Open'
                            ? AppColors.purpleColor
                            : AppColors.greyColor),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Open',
                  style: w300_13(
                    color: controller.selectedResponseType == 'Open'
                        ? AppColors.purpleColor
                        : Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  controller.selectedResponseType = 'Custom';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: controller.selectedResponseType == 'Custom'
                            ? AppColors.purpleColor
                            : AppColors.greyColor),
                    borderRadius: BorderRadius.circular(8)),
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Custom',
                  style: w300_13(
                    color: controller.selectedResponseType == 'Custom'
                        ? AppColors.purpleColor
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        if (controller.selectedResponseType != 'Open')
          Obx(() => Column(
                children: controller.customMessageList.value
                    .map((e) => responseListTile(e))
                    .toList(),
              )),
        if (controller.selectedResponseType != 'Open')
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.createCustomMessage);
                },
                child: Text(
                  '+ Add New',
                  style: w900_12(
                    color: AppColors.purpleColor,
                  ),
                )),
          )
      ],
    );
  }

  Widget responseListTile(CustomMessage message) {
    return Row(
      children: [
        Checkbox(
          value: message.isSelected,
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (!states.contains(MaterialState.selected)) {
              return AppColors.dark2GreyColor;
            }

            return AppColors.purpleColor;
          }),
          onChanged: (value) {
            /*if (value!) {
              controller.customMessageList.value.forEach((element) {
                element.isSelected = false;
              });
            }*/
            message.isSelected = value!;
            controller.customMessageList.refresh();
          },
        ),
        Expanded(
          child: Text(
            message.content!,
            style: w300_13(),
          ),
        ),
        GestureDetector(
          onTap: () {
            showConfirmationDialog(
                context, "Do you want to delete custom message?",
                yesCallback: () {
              Get.back();
              controller.deleteCustomMessage(message.id!);
            });
          },
          child: ImageView(
            path: Images.closeIcon,
            height: 15.h,
          ),
        )
      ],
    );
  }
}
