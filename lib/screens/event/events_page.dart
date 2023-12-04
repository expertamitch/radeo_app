import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/models/events_model.dart';
import 'package:redeo/screens/event/event_controller.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/not_found_widget.dart';
import '../../widgets/on_screen_loader.dart';
import '../../widgets/search_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EventController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Events',
          button1: 'Add Event',
          buttonTap1: () {
            Get.toNamed(Routes.createEventScreen);
          },
        ),
        body: Column(children: [
          SearchWidget(
              hint: 'Search Event…',
              onChange: (data) {
                controller.executeSearch(data);
              }),
          Expanded(
            child: Obx(() => controller.eventsListLoading.value
                ? OnScreenLoader()
                : controller.tempEventList.isEmpty
                    ? NotFoundWidget(
                        title: 'No Events found',
                      )
                    : ListView.builder(
                        itemCount: controller.tempEventList.length,
                        itemBuilder: (context, index) {
                          return eventListTile(
                              model: controller.tempEventList[index]);
                        })),
          )
        ]));
  }

  eventListTile({
    required EventInfoModel model,
    bool requestedBy = false,
  }) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.editEventDetailsScreen);

        if(model.type!='open')
          Get.toNamed(Routes.editEventDetailsScreen,arguments: model);
        else
          Get.toNamed(Routes.eventDetailsScreen, arguments: model);

        /*if (requestedBy)
          Get.toNamed(Routes.editEventDetailsScreen);
        else
          Get.toNamed(Routes.eventDetailsScreen, arguments: model);*/
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          minLeadingWidth: 10,
          title: Text(
            model.name ?? '',
            overflow: TextOverflow.ellipsis,
            style: w300_14(),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                model.location ?? '',
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                DateFormat('dd MMM yyyy, h:mm a')
                    .format(model.dateTime ?? DateTime.now()),
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
              if (requestedBy)
                SizedBox(
                  height: 20.h,
                ),
              if (false)
                Text(
                  'Requested by John Doe',
                  style: w600_14(color: AppColors.purpleColor)
                      .copyWith(fontStyle: FontStyle.italic),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
      ? bankAccountName
          .trim()
          .split(RegExp(' +'))
          .map((s) => s[0])
          .take(2)
          .join()
      : '';
}
