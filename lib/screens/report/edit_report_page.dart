import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/screens/report/reports_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/reports_model.dart';
import '../../styling/font_style_globle.dart';

import 'package:redeo/widgets/app_button.dart';

import '../../widgets/not_found_widget.dart';

class EditReportsPage extends StatefulWidget {
  const EditReportsPage({Key? key}) : super(key: key);

  @override
  State<EditReportsPage> createState() => _EditReportsPageState();
}

class _EditReportsPageState extends State<EditReportsPage> {
  ReportsController controller = Get.find();
  DateTime? selectedDate;

  String hoursDropDownValue = "0";
  String minDropDownValue = "0";
  String secDropDownValue = "0";

  @override
  void initState() {
    selectedDate = Get.arguments;
    Future.delayed(Duration(milliseconds: 500)).then((value) => getData());
    super.initState();
  }

  getData() async {
    await controller.getReports(DateFormat('yyyy-MM-dd').format(selectedDate!));
    if (controller.reports.isNotEmpty) {
      if (controller.reports[0].key!.toLowerCase() == 'time' &&
          controller.reports[0].value != null &&
          controller.reports[0].value!.contains(':')) {
        hoursDropDownValue =
            int.parse(controller.reports[0].value!.split(':').first.toString())
                .toString();

        minDropDownValue =
            int.parse(controller.reports[0].value!.split(':')[1].toString())
                .toString();

        secDropDownValue =
            int.parse(controller.reports[0].value!.split(':').last.toString())
                .toString();

        setState(() {});
      }
    }
  }

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
                      Map<String, dynamic> map = {};
                      map['date'] =
                          DateFormat('yyyy-MM-dd').format(selectedDate!);
                      map['time'] =
                          "${hoursDropDownValue.length == 1 ? '0$hoursDropDownValue' : hoursDropDownValue}:${minDropDownValue.length == 1 ? '0$minDropDownValue' : minDropDownValue}:${secDropDownValue.length == 1 ? '0$secDropDownValue' : secDropDownValue}";

                      controller.reports.forEach((element) {
                        if (element.key != 'Time') {
                          map[element.key!] = element.value;
                        }
                      });

                      bool success = await controller.updateReports(map);
                      if (success) Get.back();
                    },
                    child: Text(
                      'Save',
                      style: w300_12(color: Colors.white),
                    ),
                    height: 30.h,
                    width: null,
                    sodiumShapeBorder: true,
                    buttonColor: AppColors.purpleColor)
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
                'Edit Reports',
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
                lastDay: DateTime.now(),
                focusedDay: selectedDate!,
                availableCalendarFormats: {
                  CalendarFormat.month: 'Month',
                },
                // availableGestures: AvailableGestures.none,
                onDaySelected: (focusedDay, s) {
                  setState(() {
                    selectedDate = focusedDay;
                    getData();
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
                  )),
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
            if (info.key!.toLowerCase() == 'time')
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      width: 2,
                    )),
                    Container(
                      width: 55,
                      decoration: BoxDecoration(
                          color: AppColors.darkGreyColor,
                          borderRadius: BorderRadius.circular(2)),
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        value: hoursDropDownValue,
                        icon: Icon(Icons.keyboard_arrow_down_sharp,
                            weight: .5, size: 20),
                        items: List.generate(24, (index) => (index).toString())
                            .toList()
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: w300_13(),
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {
                          hoursDropDownValue = _.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 55,
                      decoration: BoxDecoration(
                          color: AppColors.darkGreyColor,
                          borderRadius: BorderRadius.circular(2)),
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_sharp,
                            weight: .5, size: 20),
                        value: minDropDownValue,
                        items: List.generate(60, (index) => (index).toString())
                            .toList()
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: w300_13(),
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {
                          minDropDownValue = _.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 55,
                      decoration: BoxDecoration(
                          color: AppColors.darkGreyColor,
                          borderRadius: BorderRadius.circular(2)),
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        isDense: true,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down_sharp,
                            weight: .5, size: 20),
                        value: secDropDownValue,
                        items: List.generate(60, (index) => (index).toString())
                            .toList()
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: w300_13(),
                            ),
                          );
                        }).toList(),
                        onChanged: (_) {
                          secDropDownValue = _.toString();
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (info.key!.toLowerCase() != 'time')
              SizedBox(
                width: 20,
                child: TextFormField(
                  initialValue: info.value == '0' ? '' : info.value,
                  style: w300_13(),
                  onChanged: (data) {
                    info.value = data;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: '0',
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: 20, minWidth: 20),
                  ),
                ),
              ),
          ],
        ));
  }
}
