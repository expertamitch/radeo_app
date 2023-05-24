import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/image_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class FieldServicePage extends StatefulWidget {
  const FieldServicePage({Key? key}) : super(key: key);

  @override
  State<FieldServicePage> createState() => _FieldServicePageState();
}

class _FieldServicePageState extends State<FieldServicePage> {
  DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Field Service'),
        body: Column(children: [
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
          Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return filedServiceListTile(
                      dateTime: DateTime.now(),
                      location:
                          '2006 Chapmans Lane, San Francisc 2006 Chapmans Lane, San Franciscoo…',
                      leadingIconPath: Images.locationIcon,
                    );
                  }))
        ]));
  }

  filedServiceListTile({
    required DateTime dateTime,
    required String location,
    required String leadingIconPath,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.noticeOfEventSummaryScreen);
        // FiledServiceMapPage
      },
      child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 15,
                    width: 30,
                    alignment: Alignment.centerLeft,
                    child: ImageView(
                      path: leadingIconPath,
                      color: AppColors.purpleColor,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      location,
                      style: w300_12(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 5),
                child: Text(
                  DateFormat('dd MMM yyyy').format(dateTime),
                  style: w300_10(color: AppColors.dark2GreyColor),
                ),
              ),
            ],
          )),
    );
  }
}
