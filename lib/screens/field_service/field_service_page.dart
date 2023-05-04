import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

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
              text: 'Field Service',
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
    return ListTile(
      leading: Container(
        height: 20,
        // padding: EdgeInsets.all(1),
        child: ImageView(
          path: leadingIconPath,
          height: 30,
          color: AppColors.purpleColor,
        ),
      ),
      minLeadingWidth: 10,
      title: Text(
        location,
        style: w400_12(),
      ),
      subtitle: AppText(
        text: DateFormat('MMM d, yyyy').format(dateTime),
        textSize: 12,
        color: Colors.grey,
      ),
    );
  }
}