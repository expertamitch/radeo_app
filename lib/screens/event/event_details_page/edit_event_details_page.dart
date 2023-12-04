import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:redeo/network/storage_utils.dart';
import 'package:redeo/utils/validators.dart';
import '../../../assets/images.dart';
import '../../../models/all_group_list_response_model.dart';
import '../../../models/events_model.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';

import '../../../widgets/image_picker_sheet.dart';
import '../../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

import '../event_controller.dart';

class EditEventDetailsPage extends StatefulWidget {
  const EditEventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EditEventDetailsPage> createState() => _EditEventDetailsPageState();
}

class _EditEventDetailsPageState extends State<EditEventDetailsPage> {
  List<UserData> userList = [];
  RxList<UserData> tempUserList = RxList();
  String status = 'pending';
  EventController controller = Get.find();
  late EventInfoModel model;
  File? uploadImg;

  TextEditingController clientNameController = TextEditingController();
  TextEditingController guestCountController = TextEditingController();
  TextEditingController specialNeedsController = TextEditingController();
  RxBool reserveSpot = false.obs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    model = Get.arguments;
    userList = model.eventUsers!;
    tempUserList.value = model.eventUsers!;
    userList.forEach((element) {
      if (element.mobile == StorageUtils.getMobile()) {
        status = element.status!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              children: [
                if(status=='pending')
                AppButton(
                    onPressedFunction: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        Map<String, dynamic> map = {};

                        map = {
                          'status': reserveSpot.value ? 'accepted' : 'rejected',
                          'client_name': clientNameController.text,
                          'additional_guest': guestCountController.text,
                          'special_needs': specialNeedsController.text
                        };

                        controller
                            .updateClosedEvent(map, model.id.toString(),
                                uploadImg != null ? uploadImg!.path : null)
                            .then((value) async {
                          if (value != null) {
                            await controller.getEventsList();
                            Get.back();
                          }
                        });
                      }
                    },
                    child: Text(
                      'Submit',
                      style: w300_12(color: Colors.white),
                    ),
                    height: 30.h,
                    sodiumShapeBorder: true,
                    width: null,
                    buttonColor: AppColors.purpleColor)
              ],
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: Stack(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            height: 40,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(4)),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        // PrettyQr(
                        //   // image: AssetImage('images/twitter.png'),
                        //   typeNumber: 3,
                        //   size: 140,
                        //   data: 'https://www.google.ru',
                        //   errorCorrectLevel: QrErrorCorrectLevel.M,
                        //   roundEdges: true, elementColor: Colors.white,
                        // ),
                        ImageView(
                          path: Images.barcodeImg,
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          model.name ?? '',
                          style: w900_18(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          DateFormat('dd MMM yyyy, h:mm a')
                              .format(model.dateTime ?? DateTime.now()),
                          style: w300_13(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          model.location!,
                          style: w300_13(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: AppColors.darkGreyColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: w300_13(
                            color: AppColors.blueColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(model.description!, style: w300_12()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  status == 'pending'
                      ? Column(
                          children: [
                            Center(
                              child: Text(
                                'Requested by ${model.requested}',
                                style: w600_12(
                                  color: AppColors.blueColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.purpleColor,
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 12),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Obx(() => Row(children: [
                                    Text(
                                      'RESERVE MY SPOT',
                                      style: w600_12(color: Colors.white),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      width: 10.w,
                                    )),
                                    GestureDetector(
                                      onTap: () {
                                        reserveSpot.value = false;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.lightPurpleColor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Text(
                                          'No',
                                          style: w600_12(
                                              color: reserveSpot.value
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        reserveSpot.value = true;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.lightPurpleColor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: Text(
                                          'Yes',
                                          style: w600_12(
                                              color: !reserveSpot.value
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    )
                                  ])),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Client Name',
                                          style: w300_13(
                                            color: AppColors.blueColor,
                                          ),
                                        ),
                                        TextFormField(
                                          style: w300_13(),
                                          controller: clientNameController,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              hintStyle: w300_13(),
                                              border: InputBorder.none,
                                              hintText: 'Enter Name'),
                                          validator: Validators.validateName,
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showChooseImage().then((value) {
                                        if (value != null && value is File) {
                                          uploadImg = value;

                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: ImageView(
                                      path: uploadImg == null
                                          ? Images.smallUploadImg
                                          : uploadImg!.path,
                                      width: 60,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(thickness: 1, color: AppColors.greyColor),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Additional Guest',
                                    style: w300_13(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                  TextFormField(
                                    style: w300_13(),
                                    textInputAction: TextInputAction.next,
                                    controller: guestCountController,
                                    validator: (value) {
                                      if (value != null) {
                                        final number =
                                            num.tryParse(value.toString()) ?? 0;

                                        if (isInteger(number)) {
                                          return null;
                                        } else {
                                          return 'Invalid number';
                                        }
                                      } else {
                                        return 'Required';
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintStyle: w300_13(),
                                        border: InputBorder.none,
                                        hintText: '00'),
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 1, color: AppColors.greyColor),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Special Needs',
                                    style: w300_13(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    style: w300_13(),
                                    maxLines: 4,
                                    controller: specialNeedsController,
                                    decoration: InputDecoration(
                                        hintStyle: w300_13(
                                          color: AppColors.dark2GreyColor,
                                        ),
                                        hintText: 'Enter Needs Here…',
                                        fillColor: AppColors.lightGreyColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.lightGreyColor)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.lightGreyColor)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.lightGreyColor))),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: status == 'rejected'
                              ? Text(
                                  'You are not going in this Event',
                                  style: w600_13(color: AppColors.redColor),
                                )
                              : Text(
                                  'You are going in this Event',
                                  style: w600_13(color: AppColors.greenColor),
                                ),
                        ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();
}
