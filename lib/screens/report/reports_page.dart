import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';

import 'package:redeo/widgets/app_button.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  DateTime selectedDate = DateTime.now();
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
                      Get.toNamed(Routes.editReportsScreen);
                    },
                    child: Text(
                      'Edit',
                      style: w300_12(color: Colors.white),
                    ),
                    height: 30.h,
                    sodiumShapeBorder: true,
                    width: null,
                    buttonColor: AppColors.purpleColor),
                SizedBox(
                  width: 10.w,
                ),
                AppButton(
                    onPressedFunction: () {
                      Get.toNamed(Routes.shareReportsScreen);
                    },
                    child: Text(
                      'Share',
                      style: w300_13(color: Colors.white),
                    ),
                    height: 30.h,
                    sodiumShapeBorder: true,
                    width: null,
                    buttonColor: AppColors.blueColor),
              ],
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.maxFinite,
              color: AppColors.darkGreyColor,
              padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
              child: Text(
                'Reports',
                style: w900_30(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.borderGreyColor))),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: selectedDate,
                availableCalendarFormats: {
                  CalendarFormat.month: 'Month',
                },
                // availableGestures: AvailableGestures.none,
                onDaySelected: (focusedDay, s) {
                  setState(() {
                    selectedDate = focusedDay;
                    print('up');
                  });
                },
                currentDay: selectedDate,
                headerStyle: HeaderStyle(
                    titleTextStyle: w300_14(color: AppColors.purpleColor),
                    leftChevronVisible: false,
                    headerPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    rightChevronVisible: false),
                calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    outsideDaysVisible: false,
                    defaultTextStyle: w300_14(),
                    weekendTextStyle: w300_14(color: Colors.black),
                    selectedTextStyle: w600_16(color: Colors.blue),
                    todayTextStyle: w600_16(color: Colors.blue),
                    todayDecoration: BoxDecoration(
                        color: AppColors.lightBlueColor,
                        shape: BoxShape.circle),
                    holidayTextStyle: w300_14(color: Colors.black)),
                daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) {
                      return DateFormat('EE').format(date).toUpperCase();
                    },
                    weekdayStyle:
                        w300_12(color: AppColors.calenderWeekdaysColor),
                    weekendStyle:
                        w300_12(color: AppColors.calenderWeekdaysColor)),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGreyColor))),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time',
                            style: w600_13(),
                          ),
                          Text(
                            '24:30',
                            style: w300_13(),
                          )
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGreyColor))),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Return Visits',
                            style: w600_13(),
                          ),
                          Text(
                            '6',
                            style: w300_13(),
                          )
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGreyColor))),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bible Studies',
                            style: w600_13(),
                          ),
                          Text(
                            '6',
                            style: w300_13(),
                          )
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGreyColor))),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Return Visits',
                            style: w600_13(),
                          ),
                          Text(
                            '2',
                            style: w300_13(),
                          )
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGreyColor))),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Magazines',
                            style: w600_13(),
                          ),
                          Text(
                            '10',
                            style: w300_13(),
                          )
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGreyColor))),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Brochures',
                            style: w600_13(),
                          ),
                          Text(
                            '15',
                            style: w300_13(),
                          )
                        ],
                      )),
                  Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.borderGreyColor))),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Videos',
                            style: w600_13(),
                          ),
                          Text(
                            '3',
                            style: w300_13(),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
