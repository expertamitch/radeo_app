import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import 'package:redeo/widgets/show_toast.dart';
import '../../get_controller/notice_of_event_controller.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import '../../widgets/colors.dart';

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
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: AppColors.purpleColor),
                      onPressed: () {
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
                      child: AppText(
                        text: 'Save',
                        textSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: AppText(
              text: 'Notice of Event',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              AppText(
                                text: 'Name',
                                textSize: 14,
                                color: AppColors.blueColor,
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
                                      validator: (value) => value!.isEmpty
                                          ? 'Please enter a name'
                                          : null,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showActionSheet();
                                    },
                                    child: SizedBox(
                                      width: 80,
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
                              Divider(
                                thickness: 1,
                                color: AppColors.greyColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Location',
                                textSize: 14,
                                color: AppColors.blueColor,
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
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a location'
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Email',
                                textSize: 14,
                                color: AppColors.blueColor,
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
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter an emial'
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Telephone',
                                textSize: 14,
                                color: AppColors.blueColor,
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
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a telephone'
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Date and Time',
                                textSize: 14,
                                color: AppColors.blueColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? d = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime(3000));
                                  if (d != null) {
                                    TimeOfDay? t = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );

                                    if (t != null) {
                                      controller.selectedDate = DateTime(d.year,
                                          d.month, d.day, t.hour, t.minute);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: controller.selectedDate == null
                                          ? 'Select date'
                                          : DateFormat('EEEE, MMM d, yyyy')
                                              .format(controller.selectedDate!),
                                      textSize: 16,
                                    ),
                                    if (controller.selectedDate != null)
                                      AppText(
                                        text: DateFormat('h:mm a')
                                            .format(controller.selectedDate!),
                                        textSize: 16,
                                      ),
                                  ],
                                ),
                              ),
                              if (showDateTimeError)
                                AppText(
                                  padding: EdgeInsets.only(top: 10),
                                  text: 'Please select a date',
                                  color: Colors.red[800],
                                  textSize: 13,
                                ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Territory',
                                textSize: 14,
                                color: AppColors.blueColor,
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
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a territory'
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
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
                                                color: controller.noticeTypes ==
                                                        'Scripture'
                                                    ? AppColors.purpleColor
                                                    : AppColors.greyColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: 90,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              text: 'Scripture',
                                              textSize: 12,
                                              fontWeight: FontWeight.bold,
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
                                                color: controller.noticeTypes ==
                                                        'Magazine'
                                                    ? AppColors.purpleColor
                                                    : AppColors.greyColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: 90,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              text: 'Magazine',
                                              textSize: 12,
                                              fontWeight: FontWeight.bold,
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
                                                color: controller.noticeTypes ==
                                                        'Video'
                                                    ? AppColors.purpleColor
                                                    : AppColors.greyColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: 90,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              text: 'Video',
                                              textSize: 12,
                                              fontWeight: FontWeight.bold,
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
                                                color: controller.noticeTypes ==
                                                        'Other'
                                                    ? AppColors.purpleColor
                                                    : AppColors.greyColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        width: 90,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AppText(
                                              text: 'Other',
                                              textSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (noticeTypesError)
                                AppText(
                                  padding: EdgeInsets.only(top: 10),
                                  text: 'Please select an option',
                                  color: Colors.red[800],
                                  textSize: 13,
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              if (controller.noticeTypes.isNotEmpty)
                                TextFormField(
                                  style: w500_14(),
                                  decoration: InputDecoration(
                                      hintStyle: w500_14(
                                        color: AppColors.dark2GreyColor,
                                      ),
                                      hintText:
                                          controller.noticeTypes + ' Name',
                                      fillColor: AppColors.greyColor,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: AppColors.greyColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: AppColors.greyColor)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: AppColors.greyColor))),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? 'Please enter a name'
                                          : null,
                                ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Attributes',
                                textSize: 14,
                                color: AppColors.blueColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: AppText(
                                      text: 'Status',
                                      textSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            value: 1,
                                            groupValue:
                                                controller.attributesStatus,
                                            onChanged: (int? value) {
                                              setState(() {
                                                controller.attributesStatus =
                                                    value;
                                                showAttributesStatusError =
                                                    false;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              controller.attributesStatus = 1;
                                              showAttributesStatusError = false;
                                            }),
                                            child: AppText(
                                              text: 'Single',
                                              textSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Radio(
                                            value: 2,
                                            groupValue:
                                                controller.attributesStatus,
                                            onChanged: (int? value) {
                                              setState(() {
                                                controller.attributesStatus =
                                                    value;
                                                showAttributesStatusError =
                                                    false;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              controller.attributesStatus = 2;
                                              showAttributesStatusError = false;
                                            }),
                                            child: AppText(
                                              text: 'Married',
                                              textSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 3,
                                            groupValue:
                                                controller.attributesStatus,
                                            onChanged: (int? value) {
                                              setState(() {
                                                controller.attributesStatus =
                                                    value;
                                                showAttributesStatusError =
                                                    false;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              controller.attributesStatus = 3;
                                              showAttributesStatusError = false;
                                            }),
                                            child: AppText(
                                              text: 'Divorced',
                                              textSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (showAttributesStatusError)
                                        AppText(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 18),
                                          text: 'Please select a status',
                                          color: Colors.red[800],
                                          textSize: 13,
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: AppText(
                                      text: 'Kids',
                                      textSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 5,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        color: AppColors.greyColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: AppText(
                                            text: 'Boy',
                                            textSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 3,
                                          ),
                                        ),
                                        Container(
                                          width: 20,
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: TextFormField(
                                            controller:
                                                controller.boysController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: w500_12(),
                                            decoration: InputDecoration(
                                                hintStyle: w500_14(
                                                  color:
                                                      AppColors.dark2GreyColor,
                                                ),
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                labelText: '',
                                                border: InputBorder.none),
                                            onChanged: (value) =>
                                                setState(() {}),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    decoration: BoxDecoration(
                                        color: AppColors.greyColor,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: AppText(
                                            text: 'Girl',
                                            textSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 3,
                                          ),
                                        ),
                                        Container(
                                          width: 20,
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: TextFormField(
                                            controller:
                                                controller.girlsController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: w500_12(),
                                            decoration: InputDecoration(
                                                hintStyle: w500_14(
                                                  color:
                                                      AppColors.dark2GreyColor,
                                                ),
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                labelText: '',
                                                border: InputBorder.none),
                                            onChanged: (value) =>
                                                setState(() {}),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                          0.35 *
                                          2 +
                                      10,
                                  child: TextFormField(
                                    maxLines: 4,
                                    controller: controller.noteController,
                                    style: w500_14(),
                                    decoration: inputDecoration.copyWith(
                                        hintText: 'Notes',
                                        fillColor: AppColors.greyColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: AppColors.greyColor)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: AppColors.greyColor)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: AppColors.greyColor))),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter a note'
                                            : null,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Add Attachment',
                                textSize: 14,
                                color: AppColors.blueColor,
                              ),
                              if (showAttachmentError)
                                AppText(
                                  padding: EdgeInsets.only(top: 10),
                                  text: 'Please select a file',
                                  color: Colors.red[800],
                                  textSize: 13,
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                child: ImageView(path: Images.selectFiles),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Set Return Visit',
                                textSize: 14,
                                color: AppColors.blueColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? d = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime(3000));
                                  if (d != null) {
                                    TimeOfDay? t = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );

                                    if (t != null) {
                                      controller.setReturnVisitDate = DateTime(
                                          d.year,
                                          d.month,
                                          d.day,
                                          t.hour,
                                          t.minute);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text:
                                          controller.setReturnVisitDate == null
                                              ? 'Select date'
                                              : DateFormat('EEEE, MMM d, yyyy')
                                                  .format(controller
                                                      .setReturnVisitDate!),
                                      textSize: 16,
                                    ),
                                    if (controller.setReturnVisitDate != null)
                                      AppText(
                                        text: DateFormat('h:mm a').format(
                                            controller.setReturnVisitDate!),
                                        textSize: 16,
                                      ),
                                  ],
                                ),
                              ),
                              if (showSetReturnVisitDateTimeError)
                                AppText(
                                  padding: EdgeInsets.only(top: 10),
                                  text: 'Please select a date',
                                  color: Colors.red[800],
                                  textSize: 13,
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Indicatores',
                                textSize: 14,
                                color: AppColors.blueColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: 'Status',
                                textSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
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
                                      controller.indicatorStatus = 1;
                                      showIndicatorStatusError = false;
                                    }),
                                    child: AppText(
                                      text: 'Open for encouragment',
                                      textSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 2,
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
                                    child: AppText(
                                      text: 'Don not contract',
                                      textSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              if (showIndicatorStatusError)
                                AppText(
                                  padding: EdgeInsets.only(top: 10),
                                  text: 'Please select a indicator status',
                                  color: Colors.red[800],
                                  textSize: 13,
                                ),
                              Divider(thickness: 1, color: AppColors.greyColor),
                              AppText(
                                text: 'Level',
                                textSize: 14,
                                color: AppColors.blueColor,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (showLevelError)
                                AppText(
                                  padding: EdgeInsets.only(bottom: 10),
                                  text: 'Please select a level',
                                  color: Colors.red[800],
                                  textSize: 13,
                                ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        controller.level = 1;
                                        showLevelError = false;
                                      });
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .28,
                                        height: 60,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller.level == 1
                                                    ? AppColors.purpleColor
                                                    : AppColors.greyColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .28,
                                        height: 60,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller.level == 2
                                                    ? AppColors.purpleColor
                                                    : AppColors.greyColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .28,
                                        height: 60,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller.level == 3
                                                    ? AppColors.purpleColor
                                                    : AppColors.greyColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: SvgPicture.asset(
                                            'assets/icons/screen 18/Level 3.svg')),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ]),
                      ))))
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
