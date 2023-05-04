import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/screens/contacts/contacts_page.dart';
import 'package:redeo/widgets/app_text.dart';
import '../../../styling/app_colors.dart';
import 'cordinator/cordinator_page.dart';

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
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: AppColors.purpleColor),
                      onPressed: () {},
                      child: AppText(
                        text: 'Submit',
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
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
            child: AppText(
              text: 'Create Event',
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
                                  text: 'Event Name',
                                  textSize: 14,
                                  color: AppColors.blueColor,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'Event Name',
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.greyColor,
                                ),
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
                                        selectedDate = DateTime(d.year, d.month,
                                            d.day, t.hour, t.minute);
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
                                      AppText(
                                        text: selectedDate == null
                                            ? 'Select date'
                                            : DateFormat('EEEE, MMM d, yyyy')
                                                .format(selectedDate!),
                                        textSize: 16,
                                      ),
                                      if (selectedDate != null)
                                        AppText(
                                          text: DateFormat('h:mm a')
                                              .format(selectedDate!),
                                          textSize: 16,
                                        ),
                                    ],
                                  ),
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
                                  decoration: InputDecoration(
                                      hintText: 'Event Location',
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.greyColor,
                                ),
                                AppText(
                                  text: 'Description',
                                  textSize: 14,
                                  color: AppColors.blueColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                      hintText: 'Enter Description…',
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
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.greyColor,
                                ),
                                AppText(
                                  text: 'Contacts',
                                  textSize: 14,
                                  color: AppColors.blueColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(ContactPage());
                                  },
                                  child: AppText(
                                    text:
                                        'Select Groups, Redeo Contacts, Contacts',
                                    textSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.greyColor,
                                ),
                                AppText(
                                  text: 'Cordinator',
                                  textSize: 14,
                                  color: AppColors.blueColor,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(CordinatorPage());
                                  },
                                  child: AppText(
                                    text: 'Select Cordinator',
                                    textSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.greyColor,
                                ),
                                AppText(
                                  text: 'Recurrence',
                                  textSize: 14,
                                  color: AppColors.blueColor,
                                ),
                                SizedBox(
                                  height: 10,
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
                                        child: AppText(
                                          text: 'Once a Week',
                                          color: selectedRecurrence ==
                                                  'Once a Week'
                                              ? AppColors.purpleColor
                                              : Colors.black,
                                          textSize: 14,
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
                                        width: 130,
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
                                        child: AppText(
                                          text: 'Once a Month',
                                          color: selectedRecurrence ==
                                                  'Once a Month'
                                              ? AppColors.purpleColor
                                              : Colors.black,
                                          textSize: 14,
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
                                        child: AppText(
                                          text: 'Once a Year',
                                          color: selectedRecurrence ==
                                                  'Once a Year'
                                              ? AppColors.purpleColor
                                              : Colors.black,
                                          textSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ])))))
        ]));
  }
}
