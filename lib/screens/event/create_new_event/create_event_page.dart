import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/widgets/app_text.dart';

import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;

  String? selectedRecurrence; //Once a Week, Once a Month, Once a Year

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
                    onPressedFunction: () {},
                    child: Text(
                      'Submit',
                      style: w700_12(color: Colors.white),
                    ),
                    sodiumShapeBorder: true,
                    width: null,
                    height: 30.h,
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
              'Create Event',
              style: w700_30(),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Event Name',
                                    style: w400_13(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                  TextFormField(
                                    style: w300_14(),
                                    decoration: InputDecoration(
                                        hintStyle: w300_14(
                                          color: AppColors.dark2GreyColor,
                                        ),
                                        hintText: 'Event Name',
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
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
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor:
                                                    AppColors.purpleColor,
                                                accentColor:
                                                    AppColors.purpleColor,
                                                colorScheme: ColorScheme.light(
                                                    primary:
                                                        AppColors.purpleColor),
                                                buttonTheme: ButtonThemeData(
                                                    textTheme: ButtonTextTheme
                                                        .primary),
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
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor:
                                                    AppColors.purpleColor,
                                                accentColor:
                                                    AppColors.purpleColor,
                                                colorScheme: ColorScheme.light(
                                                    primary:
                                                        AppColors.purpleColor),
                                                buttonTheme: ButtonThemeData(
                                                    textTheme: ButtonTextTheme
                                                        .primary),
                                              ),
                                              child: child!,
                                            );
                                          },
                                          initialTime: TimeOfDay.now(),
                                        );

                                        if (t != null) {
                                          selectedDate = DateTime(d.year,
                                              d.month, d.day, t.hour, t.minute);
                                        } else {
                                          selectedDate =
                                              DateTime(d.year, d.month, d.day);
                                        }
                                        setState(() {
                                          // showDateTimeError = false;
                                        });
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedDate == null
                                              ? 'Select date'
                                              : DateFormat('EEEE, MMM d, yyyy')
                                                  .format(selectedDate!),
                                          // textSize: 16,
                                          style: w500_14(
                                              color: AppColors.dark2GreyColor),
                                        ),
                                        if (selectedDate != null)
                                          Text(
                                            DateFormat('h:mm a')
                                                .format(selectedDate!),
                                            style: w500_14(),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
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
                                    style: w300_14(),
                                    decoration: InputDecoration(
                                        hintStyle: w300_14(
                                          color: AppColors.dark2GreyColor,
                                        ),
                                        hintText: 'Enter Location',
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: w400_13(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    style: w300_14(),
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                        hintStyle: w300_14(
                                          color: AppColors.dark2GreyColor,
                                        ),
                                        hintText: 'Enter Description…',
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
                                    validator: (value) =>
                                        value == null || value.isEmpty
                                            ? 'Please enter a name'
                                            : null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Invitee',
                                    style: w400_13(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.inviteeScreen);
                                    },
                                    child: Text(
                                      'Select Groups, Redeo Contacts, Contacts',
                                      style: w400_14(
                                          color: AppColors.dark2GreyColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recurrence',
                                    style: w400_13(
                                      color: AppColors.blueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedRecurrence = 'Once a Week';
                                          });
                                        },
                                        child: Container(
                                          width: 130,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: selectedRecurrence ==
                                                          'Once a Week'
                                                      ? AppColors.purpleColor
                                                      : AppColors.greyColor),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 8),
                                          child: Text(
                                            'Once a Week',
                                            style: w400_13(
                                              color: selectedRecurrence ==
                                                      'Once a Week'
                                                  ? AppColors.purpleColor
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedRecurrence = 'Once a Month';
                                          });
                                        },
                                        child: Container(
                                          width: 135,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: selectedRecurrence ==
                                                          'Once a Month'
                                                      ? AppColors.purpleColor
                                                      : AppColors.greyColor),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 8),
                                          child: Text(
                                            'Once a Month',
                                            style: w400_13(
                                              color: selectedRecurrence ==
                                                      'Once a Month'
                                                  ? AppColors.purpleColor
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedRecurrence = 'Once a Year';
                                          });
                                        },
                                        child: Container(
                                          width: 130,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: selectedRecurrence ==
                                                          'Once a Year'
                                                      ? AppColors.purpleColor
                                                      : AppColors.greyColor),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 8),
                                          child: Text(
                                            'Once a Year',
                                            style: w400_13(
                                              color: selectedRecurrence ==
                                                      'Once a Year'
                                                  ? AppColors.purpleColor
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                          ]))))
        ]));
  }
}
