import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/models/return_visit_list_model.dart';
import 'package:redeo/screens/notice_of_event/notice_of_event_controller.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/common_drop_down.dart';
import '../../widgets/tiles/disabled_text_field.dart';

class CreateReturnPage extends StatefulWidget {
  const CreateReturnPage({Key? key}) : super(key: key);

  @override
  State<CreateReturnPage> createState() => _CreateReturnPageState();
}

class _CreateReturnPageState extends State<CreateReturnPage> {
  NOEModel noeModel = Get.arguments;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showSetReturnVisitDateTimeError = false;
  bool showIndicatorStatusError = false;
  bool showLevelError = false;

  DateTime? setReturnVisitDate;
  String? selectedTimePeroid; // 'Everyday','Weekly','Monthly','Yearly'
  String? selectedNotifyMe; // 'Everyday','Weekly','Monthly','Yearly'
  int? indicatorStatus; //openForEncouragment, All Set
  int? level;

  String? selectedTimePeroidDD; // 'Everyday','Weekly','Monthly','Yearly'
  String? selectedNotifyMeDD; // 'Everyday','Weekly','Monthly','Yearly'
  bool showTimePeroidDDError = false;
  bool showNotifyMeDDError = false;
  bool notifySelf = false;

  TextEditingController detailsController = TextEditingController();

  NoticeOfEventController controller = Get.find();

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
                    onPressedFunction: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                      setState(() {});

                      bool isValid = true;

                      if (selectedTimePeroidDD == null) {
                        showTimePeroidDDError = true;
                        isValid = false;
                      }

                      if (selectedNotifyMeDD == null) {
                        showNotifyMeDDError = true;
                        isValid = false;
                      }

                      if (setReturnVisitDate == null) {
                        showSetReturnVisitDateTimeError = true;
                        isValid = false;
                      }
                      if (indicatorStatus == null) {
                        showIndicatorStatusError = true;
                        isValid = false;
                      }

                      if (level == null) {
                        showLevelError = true;
                        isValid = false;
                      }
                      if (_formKey.currentState!.validate() == false) {
                        isValid = false;
                      }

                      if (isValid) {
                        Map<String, dynamic> map = {};

                        map = {
                          'noe_id': noeModel.id,
                          'return_visit_type':
                              selectedTimePeroidDD!.contains('ly')
                                  ? selectedTimePeroidDD!
                                      .replaceAll('ly', '')
                                      .toLowerCase()
                                  : selectedTimePeroidDD!.toLowerCase(), //
                          'notification_self':
                              selectedNotifyMeDD!.contains('ly')
                                  ? selectedNotifyMeDD!
                                      .replaceAll('ly', '')
                                      .toLowerCase()
                                  : selectedNotifyMeDD!.toLowerCase(), //
                          'notification_other': !notifySelf ? 0 : 1, //
                          'level': level == 1
                              ? 'cloud'
                              : level == 2
                                  ? 'rain'
                                  : 'tree',
                          'indicators': indicatorStatus == 1
                              ? 'open-for-encourgament'
                              : 'do-not-call',
                          'description': detailsController.text,
                          'return_date': DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(setReturnVisitDate!),
                        };

                        bool success = await controller.createReturn(map);
                        if (success) {
                          await controller.getNOEList();
                          NOEModel model = controller.noeList.lastWhere(
                              (element) => element.id == noeModel.id);
                          Get.back(result: model);
                        }
                      }
                    },
                    child: Text(
                      'Save',
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
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              'Create Return',
              style: w900_30(),
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
                child: AppTextField(
                  hint: 'Details',
                  mainHint: 'Enter Details',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: detailsController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a details' : null,
                  keyboardType: TextInputType.name,
                  action: TextInputAction.done,
                ),
              ),
              getDivider(),
              getReturnVisit(),
              getDivider(),
              getIndicators(),
              getDivider(),
              getLevel(),
            ]),
          )))
        ]));
  }

  Widget getReturnVisit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DisabledTextField(
            hint: 'Set Return Visit',
            showError: showSetReturnVisitDateTimeError,
            mainHint: 'Select date',
            text: setReturnVisitDate != null
                ? DateFormat('MMMM,dd yyyy, hh:mm a')
                    .format(setReturnVisitDate!)
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
                  setReturnVisitDate =
                      DateTime(d.year, d.month, d.day, t.hour, t.minute);
                } else {
                  setReturnVisitDate = DateTime(d.year, d.month, d.day);
                }
              }
              setState(() {
                showSetReturnVisitDateTimeError = false;
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
              value: selectedTimePeroidDD,
              data: ['Everyday', 'Weekly', 'Monthly', 'Yearly'],
              onChanged: (val) {
                selectedTimePeroidDD = val;
                showTimePeroidDDError = false;
                setState(() {});
              }),
          if (showTimePeroidDDError)
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
              value: selectedNotifyMeDD,
              data: ['Everyday', 'Weekly', 'Monthly', 'Yearly'],
              onChanged: (val) {
                selectedNotifyMeDD = val;
                showNotifyMeDDError = false;
                setState(() {});
              }),
          if (showNotifyMeDDError)
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
                  'Notify ${noeModel.name!}',
                  style: w300_13(),
                ),
              ),
              Transform.scale(
                scale: 0.6,
                child: CupertinoSwitch(
                  activeColor: AppColors.purpleColor,
                  value: notifySelf,
                  onChanged: (value) {
                    notifySelf = value;
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
                groupValue: indicatorStatus,
                activeColor: AppColors.purpleColor,
                onChanged: (int? value) {
                  setState(() {
                    indicatorStatus = value;
                    showIndicatorStatusError = false;
                  });
                },
              ),
              GestureDetector(
                onTap: () => setState(() {
                  indicatorStatus = 1;
                  showIndicatorStatusError = false;
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
                groupValue: indicatorStatus,
                onChanged: (int? value) {
                  setState(() {
                    indicatorStatus = value;
                    showIndicatorStatusError = false;
                  });
                },
              ),
              GestureDetector(
                onTap: () => setState(() {
                  indicatorStatus = 2;
                  showIndicatorStatusError = false;
                }),
                child: Text(
                  controller.indicatorsList[1],
                  style: w300_13(),
                ),
              ),
            ],
          ),
          if (showIndicatorStatusError)
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
                    level = 1;
                    showLevelError = false;
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .28,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: level == 1
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        SvgPicture.asset('assets/icons/screen 18/Level 1.svg')),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    level = 2;
                    showLevelError = false;
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .28,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: level == 2
                                ? AppColors.purpleColor
                                : AppColors.greyColor),
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        SvgPicture.asset('assets/icons/screen 18/Level 2.svg')),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    level = 3;
                    showLevelError = false;
                  });
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .28,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: level == 3
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
          if (showLevelError)
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
}
