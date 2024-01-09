import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/screens/report/reports_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/not_found_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/reports_model.dart';
import '../../route/routes.dart';
import '../../styling/font_style_globle.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  ReportsController controller = Get.find();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Reports',
          button1: 'Edit',
          button2: 'Share',
          buttonTap1: () async {
            await Get.toNamed(Routes.editReportsScreen,
                arguments: selectedDate);
            controller
                .getReports(DateFormat('yyyy-MM-dd').format(selectedDate));
          },
          buttonTap2: () {
            Share.share('Share example');
            // Get.toNamed(Routes.shareReportsScreen);
          },
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.borderGreyColor))),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.now(),
                focusedDay: selectedDate,
                availableCalendarFormats: {
                  CalendarFormat.month: 'Month',
                },
                // availableGestures: AvailableGestures.none,
                onDaySelected: (focusedDay, s) {
                  setState(() {
                    selectedDate = focusedDay;
                    controller.getReports(
                        DateFormat('yyyy-MM-dd').format(selectedDate));
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
            Obx(() => controller.reports.isEmpty && !controller.loading.value
                ? NotFoundWidget()
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView.builder(
                        itemBuilder: (c, i) {
                          return getItem(controller.reports[i]);
                        },
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.reports.length),
                  ))
          ]),
        ));
  }

  Widget getItem(ReportInfo info) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              info.key!,
              style: w600_13(),
            ),
            Text(
              info.value ?? '',
              style: w300_13(),
            )
          ],
        ));
  }
}
