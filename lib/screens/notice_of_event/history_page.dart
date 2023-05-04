import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 20),
            child: AppText(
              text: 'History',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: AppColors.greyColor),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    if (index == 5)
                      return historyListTile(
                          noteString:
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et',
                          dateTime: DateTime.now(),
                          subTitle: '2006 Chapmans Lane, San Francisco…',
                          leadingIconPath: Images.locationIcon,
                          trailingLevelPath: Images.level1Icon);
                    return historyListTile(
                        dateTime: DateTime.now(),
                        subTitle: '2006 Chapmans Lane, San Francisco…',
                        leadingIconPath: Images.locationIcon,
                        trailingLevelPath: Images.level1Icon);
                  }))
        ]));
  }

  historyListTile(
      {required DateTime dateTime,
      required String subTitle,
      required String leadingIconPath,
      required String trailingLevelPath,
      String? noteString}) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 35,
            // padding: EdgeInsets.all(1),
            child: ImageView(
              path: leadingIconPath,
              height: 30,
              color: AppColors.purpleColor,
            ),
          ),
          trailing: SvgPicture.asset(
            trailingLevelPath,
            height: 35,
          ),
          title: AppText(
            text: DateFormat('EEEE, MMM d, yyyy | h:mm a').format(dateTime),
            textSize: 14,
          ),
          subtitle: AppText(
            text: subTitle,
            textSize: 14,
            color: Colors.grey,
          ),
        ),
        if (noteString != null)
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.lightGreyColor,
                borderRadius: BorderRadius.circular(4)),
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(10),
            child: Text(
              noteString,
              style: w400_12(color: Colors.grey),
            ),
          ),
      ],
    );
  }
}
