import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/models/custom_message_model.dart';
import 'package:redeo/screens/create_message/message_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../models/selected_file_model.dart';
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
  bool response = false;
  MessageController controller = Get.find();
  bool selectedFiles = false;

  Rx<SelectedFileModel>? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Message',
        button1: 'Review',
        buttonTap1: () {
          Get.toNamed(Routes.reviewMessageScreen);
        },
      ),
      body: Column(children: [
        Expanded(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attachment',
                        style: w300_13(
                          color: AppColors.blueColor,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      getAttachment(),
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
                              value: response,
                              onChanged: (value) {
                                setState(() {
                                  response = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      if (response) getResponseWidget(),
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
                            child: PrettyQr(
                              // image: AssetImage('images/twitter.png'),
                              typeNumber: 3,
                              size: 130,
                              data: 'https://www.google.ru',
                              errorCorrectLevel: QrErrorCorrectLevel.M,
                              roundEdges: true,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ]))
              ],
            ),
          ),
        ),
      ]),
    );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.selectedMessageType = 'Text';
                      });
                      Get.toNamed(Routes.selectTextMessageScreen);
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
                      setState(() {
                        controller.selectedMessageType = 'Audio';
                      });

                      Get.toNamed(Routes.selectAudioMessageScreen);
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
                      setState(() {
                        controller.selectedMessageType = 'Video';
                      });

                      Get.toNamed(Routes.selectVideoMessageScreen);
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
              ),
              SizedBox(
                height: 10.h,
              ),
              if (controller.selectedMessageType == 'Text')
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.lightGreyColor),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna',
                      style: w300_13(color: AppColors.dark2GreyColor),
                    )),
              SizedBox(
                height: 10.h,
              ),
              if (controller.selectedMessageType == 'Audio')
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightGreyColor),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
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
                            'Audiofile_23052023',
                            style: w300_13(),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '00:12',
                                style: w300_10(color: AppColors.dark2GreyColor),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '12 KB',
                                style: w300_10(color: AppColors.dark2GreyColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 5,
                      )),
                      GestureDetector(
                        onTap: () {
                          controller.selectedMessageType = null;
                          setState(() {});
                        },
                        child: ImageView(
                          path: Images.closeIcon,
                          width: 15,
                          color: AppColors.purpleColor,
                        ),
                      )
                    ],
                  ),
                ),
              if (controller.selectedMessageType == 'Video')
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.lightGreyColor),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      ImageView(
                        path: 'assets/dummy_data/video 02.png',
                        height: 50,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'vidofile_23052023',
                            style: w300_13(),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '00:12',
                                style: w300_10(color: AppColors.dark2GreyColor),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                '12 KB',
                                style: w300_10(color: AppColors.dark2GreyColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                          child: SizedBox(
                        width: 5,
                      )),
                      GestureDetector(
                        onTap: () {
                          controller.selectedMessageType = null;
                          setState(() {});
                        },
                        child: ImageView(
                          path: Images.closeIcon,
                          width: 15,
                          color: AppColors.purpleColor,
                        ),
                      )
                    ],
                  ),
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

  getResponseWidget() {
    return Obx(() => Column(
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
            for (CustomMessage message in controller.customMessageList.value)
              responseListTile(message),
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
        ));
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
            if (value!) {
              controller.customMessageList.value.forEach((element) {
                element.isSelected = false;
              });
            }
            message.isSelected = value;
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
            showDeleteConfirmation(
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

  getAttachment() {
    if (selectedFiles)
      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  'Filename_23052023',
                  style: w300_13(),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFiles = false;
                    });
                  },
                  child: ImageView(
                    path: Images.closeIcon,
                    width: 10,
                    color: AppColors.purpleColor,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedFiles = true;
          });
        },
        child: DottedBorder(
          color: AppColors.greyColor,
          strokeWidth: 1,
          dashPattern: [5, 5],
          borderType: BorderType.RRect,
          radius: Radius.circular(8),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageView(
                path: Images.attachIcon,
                color: AppColors.purpleColor,
                height: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Select Files',
                style: w300_13(),
              )
            ],
          ),
        ));
  }
}
