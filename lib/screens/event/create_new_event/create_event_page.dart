import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/screens/event/event_controller.dart';
import 'package:redeo/widgets/app_button.dart';
import 'package:redeo/widgets/loader.dart';

import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../widgets/tiles/disabled_text_field.dart';
import '../../invite/controller/invite_controller.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InviteController inviteController = Get.put(
    InviteController(),
    permanent: false,
  );
  DateTime? selectedDate;
  bool openEvent = true;
  String selectedRecurrence = 'Daily'; //Once a Week, Once a Month, Once a Year

  bool showSetReturnVisitDateTimeError = false;
  bool showInviteeError = false;
  DateTime? datetime;

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  EventController controller = Get.find();

  @override
  void initState() {
    inviteController.redeoList
        .where((element) => element.selected)
        .forEach((e) {
      e.isAttendant = false;
      e.isVisible = true;
    });

    inviteController.contacts.where((element) => element.selected).forEach((e) {
      e.isAttendant = false;
      e.isVisible = true;
    });

    inviteController.groupsList
        .where((element) => element.selected)
        .forEach((element) {
      element.users!.forEach((users) {
        users.users!.forEach((e) {
          e.isLocalAttendant = false;
          e.isVisible = true;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              children: [
                AppButton(
                    onPressedFunction: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                      setState(() {});

                      bool isValid = true;

                      if (datetime == null) {
                        showSetReturnVisitDateTimeError = true;
                        isValid = false;
                      }

                      if (inviteController.selectedMembersCount.value == 0) {
                        showInviteeError = true;
                        isValid = false;
                      }

                      if (_formKey.currentState!.validate() == false) {
                        isValid = false;
                      }

                      if (isValid) {
                        Map<String, dynamic> data = {};

                        data['name'] = nameController.text;
                        data['location'] = locationController.text;
                        data['description'] = descController.text;
                        data['date_time'] =
                            DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime!);

                        data['type'] = openEvent ? 'open' : 'closed';
                        data['recurrence'] = selectedRecurrence == 'Daily'
                            ? 'everyday'
                            : selectedRecurrence == 'Once a Year'
                                ? 'every-year'
                                : selectedRecurrence == 'Once a Month'
                                    ? 'every-month'
                                    : 'every-week';

                        List<Map<String, dynamic>> usersArray = [];

                        inviteController.groupsList
                            .where((p0) => p0.selected)
                            .forEach((element) {
                          element.users?.forEach((element1) {
                            if (element1.users!.length > 0) {
                              element1.users!.forEach((data) {
                                usersArray.add({
                                  'name':
                                      "${data.firstName ?? ''} ${data.lastName ?? ''}",
                                  'mobile': data.mobile ?? '',
                                  'contact_type': 'group',
                                  'from_group_id':
                                      element1.contactType == 'group'
                                          ? data.from_group_id
                                          : null,
                                  'contact_type': element1.contactType
                                });
                              });
                            }
                          });
                        });

                        inviteController.redeoList
                            .where((p0) => p0.selected)
                            .forEach((element) {
                          if (element.selected)
                            usersArray.add({
                              'name':
                                  "${element.firstName ?? ''} ${element.lastName ?? ''}",
                              'mobile': element.mobile ?? '',
                              'contact_type': 'redeo',
                            });
                        });

                        inviteController.contacts
                            .where((p0) => p0.selected)
                            .forEach((element) {
                          if (element.selected)
                            usersArray.add({
                              'name':
                                  "${element.phoneContact.name.first ?? ''} ${element.phoneContact.name.last ?? ''}",
                              'mobile':
                                  element.phoneContact.phones[0].number ?? '',
                              'contact_type': 'phone',
                            });
                        });

                        data['contacts'] = usersArray;

                        bool success = await controller.createEvent(data);
                        if (success) {
                          showLoader();
                          await controller.getEventsList();
                          hideLoader();
                          Get.back();
                        }
                      }
                    },
                    child: Text(
                      'Submit',
                      style: w300_12(color: Colors.white),
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
              style: w900_30(),
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
                            getEventName(),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            getDateAndTime(),
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
                            getLocation(),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            getDesc(),
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
                            getInvitee(),
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
                            getRecurrance(),
                            SizedBox(
                              height: 10.h,
                            ),
                            Divider(
                              thickness: 1,
                              color: AppColors.greyColor,
                            ),
                            getEventType(),
                            SizedBox(
                              height: 30.h,
                            ),
                          ]))))
        ])));
  }

  Widget getEventName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Name',
            style: w300_13(
              color: AppColors.blueColor,
            ),
          ),
          TextFormField(
            style: w300_13(),
            controller: nameController,
            validator: (value) =>
                value!.isEmpty ? 'Please enter event name' : null,
            decoration: InputDecoration(
                hintStyle: w300_13(),
                hintText: 'Event Name',
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none),
            keyboardType: TextInputType.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }

  Widget getDateAndTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: DisabledTextField(
        hint: 'Date and Time',
        showError: showSetReturnVisitDateTimeError,
        mainHint: 'Select date',
        text: datetime != null
            ? DateFormat('MMMM,dd yyyy, hh:mm a').format(datetime!)
            : null,
        error: 'Please select a date',
        onTap: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          DateTime? d = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365 * 2)),
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
              datetime = DateTime(d.year, d.month, d.day, t.hour, t.minute);
            } else {
              datetime = DateTime(d.year, d.month, d.day);
            }
          }
          setState(() {
            showSetReturnVisitDateTimeError = false;
          });
        },
      ),
    );
  }

  Widget getLocation() {
    return Padding(
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
            controller: locationController,
            validator: (value) =>
                value!.isEmpty ? 'Please enter location' : null,
            decoration: InputDecoration(
                hintStyle: w300_13(),
                hintText: 'Enter Location',
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
          ),
        ],
      ),
    );
  }

  Widget getDesc() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Description',
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
            controller: descController,
            validator: (value) =>
                value!.isEmpty ? 'Please enter event description' : null,
            decoration: InputDecoration(
                hintStyle: w300_13(
                  color: AppColors.dark2GreyColor,
                ),
                hintText: 'Enter Description…',
                fillColor: AppColors.lightGreyColor,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.lightGreyColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.lightGreyColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.lightGreyColor))),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }

  Widget getInvitee() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: DisabledTextField(
        hint: 'Invitee',
        showError: showInviteeError,
        mainHint: 'Select invitees',
        text: '${inviteController.selectedMembersCount.value} Members selected',
        error: 'Please select invitee',
        onTap: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          await Get.toNamed(Routes.inviteeScreen);
          if(inviteController.selectedMembersCount.value >0)
          showInviteeError =false ;

          setState(() {});
        },
      ),
    );
  }

  Widget getRecurrance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recurrence',
            style: w300_13(
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
                    selectedRecurrence = 'Daily';
                  });
                },
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: selectedRecurrence == 'Daily'
                              ? AppColors.purpleColor
                              : AppColors.greyColor),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Daily',
                    style: w300_13(
                      color: selectedRecurrence == 'Daily'
                          ? AppColors.purpleColor
                          : Colors.black,
                    ),
                  ),
                ),
              ),
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
                          color: selectedRecurrence == 'Once a Week'
                              ? AppColors.purpleColor
                              : AppColors.greyColor),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Once a Week',
                    style: w300_13(
                      color: selectedRecurrence == 'Once a Week'
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
                          color: selectedRecurrence == 'Once a Month'
                              ? AppColors.purpleColor
                              : AppColors.greyColor),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Once a Month',
                    style: w300_13(
                      color: selectedRecurrence == 'Once a Month'
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
                          color: selectedRecurrence == 'Once a Year'
                              ? AppColors.purpleColor
                              : AppColors.greyColor),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Once a Year',
                    style: w300_13(
                      color: selectedRecurrence == 'Once a Year'
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
    );
  }

  Widget getEventType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event type',
            style: w300_13(
              color: AppColors.blueColor,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              AppButton(
                  onPressedFunction: () {
                    openEvent = true;
                    setState(() {});
                  },
                  child: Text('Open', style: w300_13(color: Colors.white)),
                  height: 30.h,
                  sodiumShapeBorder: true,
                  width: 80.w,
                  buttonColor: openEvent
                      ? AppColors.purpleColor
                      : AppColors.dark2GreyColor),
              SizedBox(
                width: 10.w,
              ),
              AppButton(
                  onPressedFunction: () {
                    openEvent = false;
                    setState(() {});
                  },
                  child: Text('Closed', style: w300_13(color: Colors.white)),
                  height: 30.h,
                  sodiumShapeBorder: true,
                  width: 80.w,
                  buttonColor: !openEvent
                      ? AppColors.purpleColor
                      : AppColors.dark2GreyColor)
            ],
          )
        ],
      ),
    );
  }
}
