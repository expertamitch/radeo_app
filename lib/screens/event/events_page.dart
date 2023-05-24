import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/common_app_bar.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          Container(
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                ImageView(
                  path: Images.searchIcon,
                  color: Colors.purple,
                ),
                SizedBox(width: 15.w),
                Flexible(
                    child: TextFormField(
                  style: w300_13(),
                  decoration: InputDecoration(
                      hintStyle: w300_13(
                        color: AppColors.dark2GreyColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Event...',
                      isDense: true),
                ))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return eventListTile(
                        dateTime: DateTime.now(),
                        name: 'John Doe',
                        location:
                            '2006 Chapmans Lane, San Francisc 2006 Chapmans Lane, San Franciscoo…',
                        leadingIconPath: Images.locationIcon,
                        requestedBy: index == 1);
                  }))
        ]));
  }

  eventListTile({
    required DateTime dateTime,
    required String name,
    required String location,
    required String leadingIconPath,
    bool requestedBy = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (requestedBy)
          Get.toNamed(Routes.editEventDetailsScreen);
        else
          Get.toNamed(Routes.eventDetailsScreen);
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          minLeadingWidth: 10,
          title: Text(
            name,
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
                location,
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                DateFormat('dd MMM yyyy, h:mm a').format(dateTime),
                style: w300_12(color: AppColors.dark2GreyColor),
              ),
              if (requestedBy)
                SizedBox(
                  height: 20.h,
                ),
              if (requestedBy)
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
