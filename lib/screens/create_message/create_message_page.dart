import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/styling/app_colors.dart';

import 'package:redeo/widgets/image_view.dart';
import '../../get_controller/create_messages_controller.dart';
import 'package:redeo/widgets/app_button.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';

class CreateMessagePage extends StatefulWidget {
  const CreateMessagePage({Key? key}) : super(key: key);

  @override
  State<CreateMessagePage> createState() => _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  bool response = false;

  CreateMessagesController getController = Get.put(CreateMessagesController());

  bool selectedFiles = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkGreyColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Row(
            children: [
              AppButton(
                  onPressedFunction: () {
                    Get.toNamed(Routes.reviewMessageScreen);
                  },
                  child: Text(
                    'Review',
                    style: w300_13(color: Colors.white),
                  ),
                  sodiumShapeBorder: true,
                  height: 30.h,
                  width: null,
                  buttonColor: AppColors.purpleColor)
            ],
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Column(children: [
        Container(
          width: double.maxFinite,
          color: AppColors.darkGreyColor,
          padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
          child: Text(
            'Create Message',
            style: w900_30(),
          ),
        ),
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
                                getController.selectedMessageType = 'Text';
                              });
                              Get.toNamed(Routes.selectTextMessageScreen);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          getController.selectedMessageType ==
                                                  'Text'
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
                                      color:
                                          getController.selectedMessageType ==
                                                  'Text'
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
                                getController.selectedMessageType = 'Audio';
                              });

                              Get.toNamed(Routes.selectAudioMessageScreen);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          getController.selectedMessageType ==
                                                  'Audio'
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
                                      color:
                                          getController.selectedMessageType ==
                                                  'Audio'
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
                                getController.selectedMessageType = 'Video';
                              });

                              Get.toNamed(Routes.selectVideoMessageScreen);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          getController.selectedMessageType ==
                                                  'Video'
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
                                      color:
                                          getController.selectedMessageType ==
                                                  'Video'
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
                      if (getController.selectedMessageType == 'Text')
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.lightGreyColor),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna',
                              style: w300_13(color: AppColors.dark2GreyColor),
                            )),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (getController.selectedMessageType == 'Audio')
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.lightGreyColor),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '00:12',
                                        style: w300_10(
                                            color: AppColors.dark2GreyColor),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '12 KB',
                                        style: w300_10(
                                            color: AppColors.dark2GreyColor),
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
                                  getController.selectedMessageType = null;
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
                      if (getController.selectedMessageType == 'Video')
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.lightGreyColor),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '00:12',
                                        style: w300_10(
                                            color: AppColors.dark2GreyColor),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '12 KB',
                                        style: w300_10(
                                            color: AppColors.dark2GreyColor),
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
                                  getController.selectedMessageType = null;
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
                  getController.selectedResponseType = 'Open';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: getController.selectedResponseType == 'Open'
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
                    color: getController.selectedResponseType == 'Open'
                        ? AppColors.purpleColor
                        : Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  getController.selectedResponseType = 'Custom';
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: getController.selectedResponseType == 'Custom'
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
                    color: getController.selectedResponseType == 'Custom'
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
        for (var r in getController.selectedResponseList) responseListTile(r),
        Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: TextButton(
              onPressed: () {},
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

  responseListTile(Map<String, dynamic> r) {
    return Row(
      children: [
        Checkbox(
          value: r['isSelected'],
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (!states.contains(MaterialState.selected)) {
              return AppColors.dark2GreyColor;
            }

            return AppColors.purpleColor;
          }),
          onChanged: (value) {
            r['isSelected'] = value;
            int currentResIndex = getController.selectedResponseList.indexOf(r);
            setState(() {
              getController.selectedResponseList[currentResIndex] = r;
            });
          },
        ),
        Flexible(
          child: Text(
            r['title'],
            style: w300_13(),
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
