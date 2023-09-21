import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/models/return_visit_list_model.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/image_view.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';
import 'field_log_controller.dart';

class FieldServicePage extends StatefulWidget {
  const FieldServicePage({Key? key}) : super(key: key);

  @override
  State<FieldServicePage> createState() => _FieldServicePageState();
}

class _FieldServicePageState extends State<FieldServicePage> {

  ScrollController _scrollController = ScrollController();
  FieldLogController controller=Get.find();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (true) {

          if (controller.haveMore) {
            controller.getFieldLog(date: DateFormat('yyyy/MM/dd').format(controller.selectedDate));
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
    super.initState();
  }




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
              lastDay: DateTime.now(),
              focusedDay: controller.selectedDate,
              availableCalendarFormats: {
                CalendarFormat.month: 'Month',
              },
              // availableGestures: AvailableGestures.none,
              onDaySelected: (focusedDay, s) {
                setState(() {
                  controller.selectedDate = focusedDay;
                  controller.page=1;
                  controller.haveMore=false;
                  controller.getFieldLog(date: DateFormat('yyyy/MM/dd').format(controller.selectedDate));
                  print('up');
                });
              },
              currentDay: controller.selectedDate,
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
          Obx(() => Expanded(
              child:controller.fieldLogLoading.value
                  ? OnScreenLoader()
                  : controller.fieldLogs.value.isEmpty
                  ? NotFoundWidget(
                title: 'No field log found',
              ): ListView.builder(
                  controller: _scrollController,
                  itemCount: controller.fieldLogs.value.length,
                  itemBuilder: (context, index) {
                    return filedServiceListTile(
                       model: controller.fieldLogs.value[index]
                     );
                  })))
        ]));
  }

  filedServiceListTile({
    required NOEModel model
   }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.returnDetailScreen, arguments: model);
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
                      path: Images.locationIcon,
                      color: AppColors.purpleColor,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      model.location??'',
                      style: w300_12(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 5),
                child: Text(
                  DateFormat('MMMM,dd yyyy, hh:mm a').format(model.dateTime!),
                  style: w300_10(color: AppColors.dark2GreyColor),
                ),
              ),
            ],
          )),
    );
  }
}
