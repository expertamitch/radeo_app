import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/common_app_bar.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

class FieldServicePage extends StatefulWidget {
  const FieldServicePage({Key? key}) : super(key: key);

  @override
  State<FieldServicePage> createState() => _FieldServicePageState();
}

class _FieldServicePageState extends State<FieldServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Field Service'),
        body: Column(children: [

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
        Get.toNamed(Routes.filedServiceMapPageScreen);
        // FiledServiceMapPage
      },
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
        child: ListTile(
          leading: Container(
            height: 18,
            child: ImageView(
              path: leadingIconPath,
              height: 30,
              color: AppColors.purpleColor,
            ),
          ),
          minLeadingWidth: 10,
          title: Text(
            location,
            style: w300_12(),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              DateFormat('dd MMM yyyy').format(dateTime),
              style: w300_10(color: AppColors.dark2GreyColor),
            ),
          ),
        ),
      ),
    );
  }
}
