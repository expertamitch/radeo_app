import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class ReturnVisitsPage extends StatefulWidget {
  const ReturnVisitsPage({Key? key}) : super(key: key);

  @override
  State<ReturnVisitsPage> createState() => _ReturnVisitsPageState();
}

class _ReturnVisitsPageState extends State<ReturnVisitsPage> {
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
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: AppText(
              text: 'Return Visits',
              textSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Divider(color: AppColors.greyColor),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return historyListTile(
                        noteString:
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et',
                        dateTime: DateTime.now(),
                        name: 'John Doe',
                        location: '2006 Chapmans Lane, San Francisco…',
                        trailingLevelPath: Images.level1Icon);
                  }))
        ]));
  }

  historyListTile(
      {required DateTime dateTime,
      required String name,
      required String location,
      required String trailingLevelPath,
      required String noteString}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: DateFormat('EEEE, MMM d, yyyy | h:mm a').format(dateTime),
                textSize: 13,
                color: AppColors.purpleColor,
                fontWeight: FontWeight.bold,
              ),
              SvgPicture.asset(
                trailingLevelPath,
                height: 30,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AppText(
            text: name,
            textSize: 14,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 5,
          ),
          AppText(
            text: location,
            textSize: 14,
            color: Colors.grey,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.lightGreyColor,
                borderRadius: BorderRadius.circular(4)),
            padding: EdgeInsets.all(10),
            child: Text(
              noteString,
              style: w300_12(color: AppColors.dark2GreyColor),
            ),
          ),
        ],
      ),
    );
  }
}
