import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../get_controller/notice_of_event_controller.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import '../../widgets/colors.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../widgets/show_toast.dart';

class CreateNoticeOfEvent extends StatefulWidget {
  const CreateNoticeOfEvent({Key? key}) : super(key: key);

  @override
  State<CreateNoticeOfEvent> createState() => _CreateNoticeOfEventState();
}

class _CreateNoticeOfEventState extends State<CreateNoticeOfEvent> {
  // File? uploadImg;
  NoticeOfEventController controller = Get.put(NoticeOfEventController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showDateTimeError = false;
  bool showSetReturnVisitDateTimeError = false;
  bool noticeTypesError = false;
  bool showAttributesStatusError = false;
  bool showIndicatorStatusError = false;
  bool showAttachmentError = false;
  bool showLevelError = false;

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
                AppButton(
                    onPressedFunction: () {
                      bool goToSummaryPage = true;
                      if (_formKey.currentState!.validate() == false) {
                        goToSummaryPage = false;
                      }
                      if (controller.uploadImg == null) {
                        showToast('Please upload image', context);
                        goToSummaryPage = false;
                      }
                      if (controller.selectedDate == null) {
                        showDateTimeError = true;
                        goToSummaryPage = false;
                      }
                      if (controller.noticeTypes.isEmpty) {
                        noticeTypesError = true;
                        goToSummaryPage = false;
                      }
                      if (controller.attributesStatus == null) {
                        showAttributesStatusError = true;
                        goToSummaryPage = false;
                      }
                      if (controller.setReturnVisitDate == null) {
                        showSetReturnVisitDateTimeError = true;
                        goToSummaryPage = false;
                      }
                      if (controller.indicatorStatus == null) {
                        showIndicatorStatusError = true;
                        goToSummaryPage = false;
                      }
                      // if (controller.attachment == null) {
                      //   showAttachmentError = true;
                      //   goToSummaryPage = false;
                      // }
                      if (controller.level == null) {
                        showLevelError = true;
                        goToSummaryPage = false;
                      }

                      setState(() {});

                      if (goToSummaryPage) {
                        Get.toNamed(Routes.noticeOfEventSummaryScreen);
                      }
                    },
                    child: Text(
                      'Save',
                      style: w500_12(color: Colors.white),
                    ),
                    height: 30,
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
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'Notice of Event',
              style: w700_30(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: TextFormField(
                            style: w500_14(),
                            decoration: InputDecoration(
                                hintStyle: w500_14(
                                  color: AppColors.dark2GreyColor,
                                ),
                                hintText: 'Name',
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none),
                            controller: controller.nameController,
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a name' : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showActionSheet();
                          },
                          child: SizedBox(
                            width: 80.w,
                            child: Row(
                              children: [
                                ImageView(
                                  path: controller.uploadImg == null
                                      ? Images.uploadImg
                                      : controller.uploadImg!.path,
                                  width: 80,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                thickness: 1,
                color: AppColors.greyColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    TextFormField(
                      style: w500_14(),
                      decoration: InputDecoration(
                          hintStyle: w500_14(
                            color: AppColors.dark2GreyColor,
                          ),
                          hintText: 'Location',
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none),
                      controller: controller.locationController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a location' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    TextFormField(
                      style: w500_14(),
                      decoration: InputDecoration(
                          hintStyle: w500_14(
                            color: AppColors.dark2GreyColor,
                          ),
                          hintText: 'Email',
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none),
                      controller: controller.emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter an email' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telephone',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    TextFormField(
                      style: w500_14(),
                      decoration: InputDecoration(
                          hintStyle: w500_14(
                            color: AppColors.dark2GreyColor,
                          ),
                          hintText: 'Telephone',
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none),
                      controller: controller.telephoneController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a telephone' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date and Time',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? d = await showDatePicker(
                            context: context,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: AppColors.purpleColor,
                                  accentColor: AppColors.purpleColor,
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.purpleColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(3000));
                        if (d != null) {
                          TimeOfDay? t = await showTimePicker(
                            context: context,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: AppColors.purpleColor,
                                  accentColor: AppColors.purpleColor,
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.purpleColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
                            initialTime: TimeOfDay.now(),
                          );

                          if (t != null) {
                            controller.selectedDate = DateTime(
                                d.year, d.month, d.day, t.hour, t.minute);
                          } else {
                            controller.selectedDate =
                                DateTime(d.year, d.month, d.day);
                          }
                          setState(() {
                            showDateTimeError = false;
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.selectedDate == null
                                ? 'Select date'
                                : DateFormat('EEEE, MMM d, yyyy')
                                    .format(controller.selectedDate!),
                            style: w500_14(
                                color: controller.selectedDate == null
                                    ? AppColors.dark2GreyColor
                                    : Colors.black),
                          ),
                          if (controller.selectedDate != null)
                            Text(
                              DateFormat('h:mm a')
                                  .format(controller.selectedDate!),
                              style: w500_14(),
                            ),
                        ],
                      ),
                    ),
                    if (showDateTimeError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a date',
                          style: w400_13(
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Territory',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    TextFormField(
                      style: w500_14(),
                      decoration: InputDecoration(
                          hintStyle: w500_14(
                            color: AppColors.dark2GreyColor,
                          ),
                          hintText: 'Territory',
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none),
                      controller: controller.territoryController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a territory' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
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
                                controller.noticeTypes = 'Scripture';
                                noticeTypesError = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          controller.noticeTypes == 'Scripture'
                                              ? AppColors.purpleColor
                                              : AppColors.greyColor),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 90,
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Scripture',
                                    style: w700_12(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.noticeTypes = 'Magazine';
                                noticeTypesError = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          controller.noticeTypes == 'Magazine'
                                              ? AppColors.purpleColor
                                              : AppColors.greyColor),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 90,
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Magazine',
                                    style: w700_12(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.noticeTypes = 'Video';
                                noticeTypesError = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: controller.noticeTypes == 'Video'
                                          ? AppColors.purpleColor
                                          : AppColors.greyColor),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 90,
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Video',
                                    style: w700_12(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                controller.noticeTypes = 'Other';
                                noticeTypesError = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: controller.noticeTypes == 'Other'
                                          ? AppColors.purpleColor
                                          : AppColors.greyColor),
                                  borderRadius: BorderRadius.circular(8)),
                              width: 90,
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Other',
                                    style: w700_12(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (noticeTypesError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select an option',
                          style: w400_13(
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (controller.noticeTypes.isNotEmpty)
                      TextFormField(
                        style: w500_14(),
                        decoration: InputDecoration(
                            hintStyle: w500_14(
                              color: AppColors.dark2GreyColor,
                            ),
                            hintText: controller.noticeTypes + ' Name',
                            fillColor: AppColors.lightGreyColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: AppColors.lightGreyColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: AppColors.lightGreyColor)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: AppColors.lightGreyColor))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a name'
                            : null,
                      ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Attributes',
                      style: w400_13(
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
                            style: w700_14(),
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
                                  groupValue: controller.attributesStatus,
                                  onChanged: (int? value) {
                                    setState(() {
                                      controller.attributesStatus = value;
                                      showAttributesStatusError = false;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    controller.attributesStatus = 1;
                                    showAttributesStatusError = false;
                                  }),
                                  child: Text(
                                    'Single',
                                    style: w500_14(),
                                  ),
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: controller.attributesStatus,
                                  onChanged: (int? value) {
                                    setState(() {
                                      controller.attributesStatus = value;
                                      showAttributesStatusError = false;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    controller.attributesStatus = 2;
                                    showAttributesStatusError = false;
                                  }),
                                  child: Text(
                                    'Married',
                                    style: w500_14(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 3,
                                  groupValue: controller.attributesStatus,
                                  onChanged: (int? value) {
                                    setState(() {
                                      controller.attributesStatus = value;
                                      showAttributesStatusError = false;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    controller.attributesStatus = 3;
                                    showAttributesStatusError = false;
                                  }),
                                  child: Text(
                                    'Divorced',
                                    style: w500_14(),
                                  ),
                                ),
                              ],
                            ),
                            if (showAttributesStatusError)
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  'Please select a status',
                                  style: w400_13(
                                    color: Colors.red[800],
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
                                  style: w700_14(),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 3.w,
                                ),
                              ),
                              Container(
                                width: 20,
                                padding: EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  controller: controller.boysController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: w500_12(),
                                  decoration: InputDecoration(
                                      hintStyle: w500_14(
                                        color: AppColors.dark2GreyColor,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      labelText: '',
                                      border: InputBorder.none),
                                  onChanged: (value) => setState(() {}),
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
                                  style: w700_14(),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 3.w,
                                ),
                              ),
                              Container(
                                width: 20,
                                padding: EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  controller: controller.girlsController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: w500_12(),
                                  decoration: InputDecoration(
                                      hintStyle: w500_14(
                                        color: AppColors.dark2GreyColor,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      labelText: '',
                                      border: InputBorder.none),
                                  onChanged: (value) => setState(() {}),
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
                        width:
                            (MediaQuery.of(context).size.width * 0.35 * 2 + 10)
                                .w,
                        child: TextFormField(
                          maxLines: 4,
                          controller: controller.noteController,
                          style: w500_14(),
                          decoration: inputDecoration.copyWith(
                              hintText: 'Notes',
                              fillColor: AppColors.lightGreyColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.lightGreyColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.lightGreyColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.lightGreyColor))),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter a note'
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Attachment',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    if (showAttachmentError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a file',
                          style: w400_13(
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      child: ImageView(path: Images.selectFiles),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set Return Visit',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime? d = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: AppColors.purpleColor,
                                  accentColor: AppColors.purpleColor,
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.purpleColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
                            lastDate: DateTime(3000));
                        if (d != null) {
                          TimeOfDay? t = await showTimePicker(
                            context: context,
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: AppColors.purpleColor,
                                  accentColor: AppColors.purpleColor,
                                  colorScheme: ColorScheme.light(
                                      primary: AppColors.purpleColor),
                                  buttonTheme: ButtonThemeData(
                                      textTheme: ButtonTextTheme.primary),
                                ),
                                child: child!,
                              );
                            },
                            initialTime: TimeOfDay.now(),
                          );

                          if (t != null) {
                            controller.setReturnVisitDate = DateTime(
                                d.year, d.month, d.day, t.hour, t.minute);
                          } else {
                            controller.setReturnVisitDate =
                                DateTime(d.year, d.month, d.day);
                          }
                        }
                        setState(() {
                          showSetReturnVisitDateTimeError = false;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.setReturnVisitDate == null
                                ? 'Select date'
                                : DateFormat('EEEE, MMM d, yyyy')
                                    .format(controller.setReturnVisitDate!),
                            style: w500_14(
                                color: controller.setReturnVisitDate == null
                                    ? AppColors.dark2GreyColor
                                    : Colors.black),
                          ),
                          if (controller.setReturnVisitDate != null)
                            Text(
                              DateFormat('h:mm a')
                                  .format(controller.setReturnVisitDate!),
                              style: w500_14(),
                            ),
                        ],
                      ),
                    ),
                    if (showSetReturnVisitDateTimeError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a date',
                          style: w400_13(
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(thickness: 1, color: AppColors.borderGreyColor),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.lightGreyColor),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        value: controller.selectedTimePeroid,
                        icon: ImageView(
                          path: Images.downArrowIcon,
                        ),
                        hint: Text(
                          'Select',
                          style: w500_14(color: AppColors.dark2GreyColor),
                        ),
                        items: <String>[
                          'Everyday',
                          'Weekly',
                          'Monthy',
                          'Yearly'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: w500_15(),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            controller.selectedTimePeroid = val;
                          });
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
                        icon: ImageView(
                          path: Images.downArrowIcon,
                        ),
                        value: controller.selectedNotifyMe,
                        hint: Text(
                          'Notify Me',
                          style: w500_14(color: AppColors.dark2GreyColor),
                        ),
                        items: <String>[
                          'Everyday',
                          'Weekly',
                          'Monthy',
                          'Yearly'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: w500_15(),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            controller.selectedNotifyMe = val;
                          });
                        },
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
                            'Notify Joe',
                            style: w400_14(),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            activeColor: AppColors.purpleColor,
                            value: false,
                            onChanged: (value) {},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Indicatores',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Status',
                      style: w700_14(),
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
                              showIndicatorStatusError = false;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            controller.indicatorStatus = 1;
                            showIndicatorStatusError = false;
                          }),
                          child: Text(
                            'Open for encouragment',
                            style: w500_14(),
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
                              showIndicatorStatusError = false;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            controller.indicatorStatus = 2;
                            showIndicatorStatusError = false;
                          }),
                          child: Text(
                            'Don not contract',
                            style: w500_14(),
                          ),
                        ),
                      ],
                    ),
                    if (showIndicatorStatusError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a indicator status',
                          style: w400_13(
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Divider(thickness: 1, color: AppColors.borderGreyColor),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Level',
                      style: w400_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (showLevelError)
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Please select a level',
                          style: w400_13(
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.level = 1;
                              showLevelError = false;
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
                              child: SvgPicture.asset(
                                  'assets/icons/screen 18/Level 1.svg')),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.level = 2;
                              showLevelError = false;
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
                              child: SvgPicture.asset(
                                  'assets/icons/screen 18/Level 2.svg')),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.level = 3;
                              showLevelError = false;
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
                              child: SvgPicture.asset(
                                  'assets/icons/screen 18/Level 3.svg')),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ]),
          )))
        ]));
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select Photo'),
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              XFile? file = await picker.pickImage(source: ImageSource.camera);

              if (file != null) {
                controller.uploadImg = File(file.path);
                setState(() {});
              }

              Navigator.pop(context);
            },
            child: const Text('Take Photo'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              XFile? file = await picker.pickImage(source: ImageSource.gallery);
              if (file != null) {
                controller.uploadImg = File(file.path);
                setState(() {});
              }
              Navigator.pop(context);
            },
            child: const Text('Choose from Library'),
          ),
        ],
      ),
    );
  }
}
