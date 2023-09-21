import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import 'package:redeo/widgets/tiles/disabled_text_field.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/validators.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/attachment_widget.dart';
import '../../widgets/colors.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_drop_down.dart';
import '../../widgets/image_picker_sheet.dart';
import '../../widgets/show_toast.dart';
import 'notice_of_event_controller.dart';

class CreateNoticeOfEvent extends StatefulWidget {
  const CreateNoticeOfEvent({Key? key}) : super(key: key);

  @override
  State<CreateNoticeOfEvent> createState() => _CreateNoticeOfEventState();
}

class _CreateNoticeOfEventState extends State<CreateNoticeOfEvent> {
  List<FocusNode> nodes = [];

  // File? controller.uploadImg;
  NoticeOfEventController controller = Get.find();

  @override
  void initState() {
    nodes.add(FocusNode(
      canRequestFocus: true,
    ));
    nodes.add(FocusNode(
      canRequestFocus: true,
    ));
    nodes.add(FocusNode(
      canRequestFocus: true,
    ));
    nodes.add(FocusNode(
      canRequestFocus: true,
    ));
    nodes.add(FocusNode(
      canRequestFocus: true,
    ));
    nodes.add(FocusNode(
      canRequestFocus: true,
    ));
    nodes.add(FocusNode(
      canRequestFocus: true,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Notice of Event',
          isBack: Get.arguments != null,
          button1: 'Review',
          buttonTap1: () {
            FocusManager.instance.primaryFocus?.unfocus();

            controller.autovalidateMode = AutovalidateMode.onUserInteraction;
            setState(() {});

            bool goToSummaryPage = true;

            if (controller.uploadImg == null) {
              showToast('Please upload image', context);
              goToSummaryPage = false;
            }
            if (controller.selectedDate == null) {
              controller.showDateTimeError = true;
              goToSummaryPage = false;
            }
            if (controller.attachmentFile == null) {
              controller.showAttachmentError = true;
              goToSummaryPage = false;
            }
            if (controller.territoryInfo == null) {
              controller.showTerritoryError = true;
              goToSummaryPage = false;
            }

            if (controller.selectedTimePeroidDD == null) {
              controller.showTimePeroidDDError = true;
              goToSummaryPage = false;
            }

            if (controller.selectedNotifyMeDD == null) {
              controller.showNotifyMeDDError = true;
              goToSummaryPage = false;
            }

            if (controller.contentTypes.isEmpty) {
              controller.noticeTypesError = true;
              goToSummaryPage = false;
            }
            if (controller.attributesStatus == null) {
              controller.showAttributesStatusError = true;
              goToSummaryPage = false;
            }
            if (controller.setReturnVisitDate == null) {
              controller.showSetReturnVisitDateTimeError = true;
              goToSummaryPage = false;
            }
            if (controller.indicatorStatus == null) {
              controller.showIndicatorStatusError = true;
              goToSummaryPage = false;
            }

            if (controller.level == null) {
              controller.showLevelError = true;
              goToSummaryPage = false;
            }
            if (controller.formKey.currentState!.validate() == false) {
              goToSummaryPage = false;
            }

            if (goToSummaryPage) {
              Get.toNamed(Routes.noticeOfEventSummaryScreen);
            }
          },
        ),
        body: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                getName(),
                SizedBox(
                  height: 5.h,
                ),
                getDivider(),
                getLocation(),
                getDivider(),
                getEmail(),
                getDivider(),
                getTelephone(),
                getDivider(),
                getDateTime(),
                SizedBox(
                  height: 10.h,
                ),
                getDivider(),
                getTerritory(),
                SizedBox(
                  height: 10.h,
                ),
                getDivider(),
                getScripture(),
                getDivider(),
                getAttributes(),
                getDivider(),
                addAttachment(),
                getDivider(),
                getReturnVisit(),
                SizedBox(
                  height: 10.h,
                ),
                getDivider(),
                getIndicators(),
                SizedBox(
                  height: 10.h,
                ),
                getDivider(),
                getLevel(),
              ],
            ),
          ),
        ));
  }

  Widget getName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AppTextField(
              hint: 'Name',
              currentNode: nodes[0],
              nextNode: nodes[1],
              controller: controller.nameController,
              onChanged: (v) {
                setState(() {});
              },
              autovalidateMode: controller.autovalidateMode,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a name' : null,
              keyboardType: TextInputType.name,
              action: TextInputAction.next,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          GestureDetector(
            onTap: () {
              showChooseImage().then((value) {
                if (value != null && value is File) {
                  controller.uploadImg = value;

                  setState(() {});
                }
              });
            },
            child: SizedBox(
              width: 80.w,
              child: Row(
                children: [
                  ImageView(
                    path: controller.uploadImg == null
                        ? Images.uploadImg
                        : controller.uploadImg!.path,
                    width: 80.w,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: AppTextField(
        hint: 'Location',
        currentNode: nodes[1],
        nextNode: nodes[2],
        controller: controller.locationController,
        autovalidateMode: controller.autovalidateMode,
        validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
        keyboardType: TextInputType.name,
        action: TextInputAction.next,
      ),
    );
  }

  Widget getEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: AppTextField(
        hint: 'Email',
        currentNode: nodes[2],
        nextNode: nodes[3],
        controller: controller.emailController,
        autovalidateMode: controller.autovalidateMode,
        validator: (value) => Validators.validateEmail(value),
        keyboardType: TextInputType.emailAddress,
        action: TextInputAction.next,
      ),
    );
  }

  Widget getTelephone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: AppTextField(
        hint: 'Telephone',
        currentNode: nodes[3],
        controller: controller.telephoneController,
        autovalidateMode: controller.autovalidateMode,
        validator: (value) => value!.isEmpty
            ? 'Please enter telephone'
            : value.length < 10
                ? 'Invalid length'
                : null,
        keyboardType: TextInputType.phone,
        maxLength: 12,
        action: TextInputAction.done,
      ),
    );
  }

  Widget getDateTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: DisabledTextField(
          hint: 'Date and Time',
          mainHint: 'Select date',
          text: controller.selectedDate != null
              ? DateFormat('MMMM,dd yyyy, hh:mm a')
                  .format(controller.selectedDate!)
              : null,
          error: 'Please select date and time',
          showError: controller.showDateTimeError,
          onTap: () async {
            DateTime? choosenDate = await showDatePicker(
                context: context,
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: AppColors.purpleColor,
                      hintColor: AppColors.purpleColor,
                      colorScheme:
                          ColorScheme.light(primary: AppColors.purpleColor),
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365*2)));
            if (choosenDate != null) {
              TimeOfDay? choosenTime = await showTimePicker(
                context: context,
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: AppColors.purpleColor,
                      hintColor: AppColors.purpleColor,
                      colorScheme:
                          ColorScheme.light(primary: AppColors.purpleColor),
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
                initialTime: TimeOfDay.now(),
              );

              if (choosenTime != null) {
                controller.selectedDate = DateTime(
                    choosenDate.year,
                    choosenDate.month,
                    choosenDate.day,
                    choosenTime.hour,
                    choosenTime.minute);

                setState(() {
                  controller.showDateTimeError = false;
                });
              }
            }
          }),
    );
  }

  Widget getDivider() {
    return Column(
      children: [
        Divider(
          thickness: 1,
          color: AppColors.greyColor,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }

  Widget getTerritory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: DisabledTextField(
        onTap: () {
          Get.toNamed(Routes.chooseTerritory)?.then((value) {
            if (value != null) {
              controller.territoryInfo = value;
              controller.territoryInfo!.name!;
              controller.showTerritoryError = false;
              setState(() {});
            }
          });
        },
        showError: controller.showTerritoryError,
        error: 'Please select a territory',
        hint: 'Territory',
        text: controller.territoryInfo != null
            ? controller.territoryInfo!.name
            : null,
      ),
    );
  }

  Widget getScripture() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width.w,
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.contentTypes = 'Scripture';
                      controller.noticeTypesError = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.contentTypes == 'Scripture'
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    width: 75,
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scripture',
                          style: w300_10(
                              color: controller.contentTypes == 'Scripture'
                                  ? AppColors.purpleColor
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.contentTypes = 'Magazine';
                      controller.noticeTypesError = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.contentTypes == 'Magazine'
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    width: 75,
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Magazine',
                          style: w300_10(
                              color: controller.contentTypes == 'Magazine'
                                  ? AppColors.purpleColor
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.contentTypes = 'Video';
                      controller.noticeTypesError = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.contentTypes == 'Video'
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    width: 75,
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Video',
                          style: w300_10(
                              color: controller.contentTypes == 'Video'
                                  ? AppColors.purpleColor
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.contentTypes = 'Other';
                      controller.noticeTypesError = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.contentTypes == 'Other'
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    width: 75,
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Other',
                          style: w300_10(
                              color: controller.contentTypes == 'Other'
                                  ? AppColors.purpleColor
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (controller.noticeTypesError)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Please select an option',
                style: w300_13(
                  color: AppColors.redColor,
                ),
              ),
            ),
          SizedBox(
            height: 10.h,
          ),
          if (controller.contentTypes.isNotEmpty)
            TextFormField(
              style: w300_12(),
              controller: controller.contentNameController,
              decoration: InputDecoration(
                  hintStyle: w300_12(
                    color: AppColors.dark2GreyColor,
                  ),
                  hintText: controller.contentTypes + ' Name',
                  fillColor: AppColors.lightGreyColor,
                  filled: true,
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.lightGreyColor))),
              autovalidateMode: controller.autovalidateMode,
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter a name' : null,
            ),
        ],
      ),
    );
  }

  Widget getAttributes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attributes',
            style: w300_13(
              color: AppColors.blueColor,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Status',
                  style: w600_14(),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.purpleColor;
                          }
                          return AppColors.dark2GreyColor;
                        }),
                        //  AppColors.purpleColor,
                        groupValue: controller.attributesStatus,
                        onChanged: (int? value) {
                          setState(() {
                            controller.attributesStatus = value;
                            controller.showAttributesStatusError = false;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          controller.attributesStatus = 1;
                          controller.showAttributesStatusError = false;
                        }),
                        child: Text(
                          'Single',
                          style: w300_13(),
                        ),
                      ),
                      Radio(
                        value: 2,
                        groupValue: controller.attributesStatus,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.purpleColor;
                          }
                          return AppColors.dark2GreyColor;
                        }),
                        onChanged: (int? value) {
                          setState(() {
                            controller.attributesStatus = value;
                            controller.showAttributesStatusError = false;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          controller.attributesStatus = 2;
                          controller.showAttributesStatusError = false;
                        }),
                        child: Text(
                          'Married',
                          style: w300_13(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: controller.attributesStatus,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.purpleColor;
                          }
                          return AppColors.dark2GreyColor;
                        }),
                        onChanged: (int? value) {
                          setState(() {
                            controller.attributesStatus = value;
                            controller.showAttributesStatusError = false;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          controller.attributesStatus = 3;
                          controller.showAttributesStatusError = false;
                        }),
                        child: Text(
                          'Divorced',
                          style: w300_13(),
                        ),
                      ),
                    ],
                  ),
                  if (controller.showAttributesStatusError)
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Please select a status',
                        style: w300_13(
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 20.w,
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Kids',
                  style: w600_14(),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 5.w,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Boy',
                        style: w300_13(),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: controller.boysController,
                          autovalidateMode: controller.autovalidateMode,
                          focusNode: nodes[4],
                          onFieldSubmitted: (c) {
                            FocusScope.of(context).requestFocus(nodes[5]);
                          },
                          style: w300_13(),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintStyle: w300_13(),
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              labelText: '',
                              border: InputBorder.none),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Girl',
                        style: w300_13(),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: controller.girlsController,
                          autovalidateMode: controller.autovalidateMode,
                          style: w300_13(),
                          focusNode: nodes[5],
                          onFieldSubmitted: (c) {
                            FocusScope.of(context).requestFocus(nodes[6]);
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintStyle: w300_13(),
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              labelText: '',
                              border: InputBorder.none),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: ((MediaQuery.of(context).size.width * 0.35) * 2 - 10).w,
              child: TextFormField(
                maxLines: 4,
                focusNode: nodes[6],
                controller: controller.noteController,
                style: w300_13(),
                decoration: inputDecoration.copyWith(
                    hintText: 'Notes',
                    hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    fillColor: AppColors.lightGreyColor,
                    errorStyle: w300_13(color: AppColors.redColor),
                    filled: true,
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
                autovalidateMode: controller.autovalidateMode,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter notes'
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Widget addAttachment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AttachmentWidget(
              hint: 'Add Attachment',
              title: 'Select File',
              attachment: controller.attachmentFile,
              filePickedCallback: (value) {
                controller.attachmentFile = value;
                controller.showAttachmentError = false;
                setState(() {});
              }),
          if (controller.showAttachmentError)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Please select a file',
                style: w300_13(
                  color: AppColors.redColor,
                ),
              ),
            ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Widget getReturnVisit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DisabledTextField(
            hint: 'Set Return Visit',
            showError: controller.showSetReturnVisitDateTimeError,
            mainHint: 'Select date',
            text: controller.setReturnVisitDate != null
                ? DateFormat('MMMM,dd yyyy, hh:mm a')
                    .format(controller.setReturnVisitDate!)
                : null,
            error: 'Please select a date',
            onTap: () async {
              DateTime? d = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365*2)),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: AppColors.purpleColor,
                        hintColor: AppColors.purpleColor,
                        colorScheme:
                            ColorScheme.light(primary: AppColors.purpleColor),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child!,
                    );
                  },
                  );
              if (d != null) {
                TimeOfDay? t = await showTimePicker(
                  context: context,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: AppColors.purpleColor,
                        hintColor: AppColors.purpleColor,
                        colorScheme:
                            ColorScheme.light(primary: AppColors.purpleColor),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child!,
                    );
                  },
                  initialTime: TimeOfDay.now(),
                );

                if (t != null) {
                  controller.setReturnVisitDate =
                      DateTime(d.year, d.month, d.day, t.hour, t.minute);
                } else {
                  controller.setReturnVisitDate =
                      DateTime(d.year, d.month, d.day);
                }
              }
              setState(() {
                controller.showSetReturnVisitDateTimeError = false;
              });
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(thickness: 1, color: AppColors.borderGreyColor),
          SizedBox(
            height: 10.h,
          ),
          CommonDropDown(
              hint: 'Select Time Period',
              mainHint: 'Select',
              value: controller.selectedTimePeroidDD,
              data: ['Everyday', 'Weekly', 'Monthly', 'Yearly'],
              onChanged: (val) {
                controller.selectedTimePeroidDD = val;
                controller.showTimePeroidDDError = false;
                setState(() {});
              }),
          if (controller.showTimePeroidDDError)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Please select time period',
                style: w300_13(
                  color: AppColors.redColor,
                ),
              ),
            ),
          SizedBox(
            height: 15.h,
          ),
          CommonDropDown(
              hint: 'Notify Me',
              mainHint: 'Select',
              value: controller.selectedNotifyMeDD,
              data: ['Everyday', 'Weekly', 'Monthly', 'Yearly'],
              onChanged: (val) {
                controller.selectedNotifyMeDD = val;
                controller.showNotifyMeDDError = false;
                setState(() {});
              }),
          if (controller.showNotifyMeDDError)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Please select notify me period',
                style: w300_13(
                  color: AppColors.redColor,
                ),
              ),
            ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Notify ${controller.nameController.text}',
                  style: w300_13(),
                ),
              ),
              Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                  activeColor: AppColors.purpleColor,
                  value: controller.notifySelf,
                  onChanged: (value) {
                    controller.notifySelf = value;
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget getIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Indicators',
            style: w300_13(
              color: AppColors.blueColor,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Status',
            style: w600_14(),
          ),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: controller.indicatorStatus,
                activeColor: AppColors.purpleColor,
                onChanged: (int? value) {
                  setState(() {
                    controller.indicatorStatus = value;
                    controller.showIndicatorStatusError = false;
                  });
                },
              ),
              GestureDetector(
                onTap: () => setState(() {
                  controller.indicatorStatus = 1;
                  controller.showIndicatorStatusError = false;
                }),
                child: Text(
                  controller.indicatorsList[0],
                  style: w300_13(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                activeColor: AppColors.purpleColor,
                groupValue: controller.indicatorStatus,
                onChanged: (int? value) {
                  setState(() {
                    controller.indicatorStatus = value;
                    controller.showIndicatorStatusError = false;
                  });
                },
              ),
              GestureDetector(
                onTap: () => setState(() {
                  controller.indicatorStatus = 2;
                  controller.showIndicatorStatusError = false;
                }),
                child: Text(
                  controller.indicatorsList[1],
                  style: w300_13(),
                ),
              ),
            ],
          ),
          if (controller.showIndicatorStatusError)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Please select a indicator status',
                style: w300_13(
                  color: AppColors.redColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget getLevel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Level',
            style: w300_13(
              color: AppColors.blueColor,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.level = 1;
                    controller.showLevelError = false;
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .28,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.level == 1
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        SvgPicture.asset('assets/icons/screen 18/Level 1.svg')),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.level = 2;
                    controller.showLevelError = false;
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .28,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.level == 2
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        SvgPicture.asset('assets/icons/screen 18/Level 2.svg')),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.level = 3;
                    controller.showLevelError = false;
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .28,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.level == 3
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        SvgPicture.asset('assets/icons/screen 18/Level 3.svg')),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          if (controller.showLevelError)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Please select a level',
                style: w300_13(
                  color: AppColors.redColor,
                ),
              ),
            ),
          SizedBox(
            height: 20.h,
          )
        ],
      ),
    );
  }
}
