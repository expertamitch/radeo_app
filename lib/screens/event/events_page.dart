import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:redeo/widgets/image_view.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';
import 'package:redeo/widgets/app_button.dart';

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
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Row(
              children: [
                AppButton(
                    onPressedFunction: () {
                      Get.toNamed(Routes.createEventScreen);
                    },
                    child: Text(
                      'Add Event',
                      style: w700_12(color: Colors.white),
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
              'Events',
              style: w700_30(),
            ),
          ),
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
                  style: w300_14(),
                  decoration: InputDecoration(
                      hintStyle: w300_14(
                        color: AppColors.dark2GreyColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Serach Event...',
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
                    );
                  }))
        ]));
  }

  eventListTile({
    required DateTime dateTime,
    required String name,
    required String location,
    required String leadingIconPath,
  }) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.eventDetailsScreen);
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          minLeadingWidth: 10,
          title: Flexible(
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: w600_14(),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Text(
                location,
                style: w300_12(color: Colors.grey),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                DateFormat('dd MMM yyyy, h:mm a').format(dateTime),
                style: w300_12(color: Colors.grey),
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
