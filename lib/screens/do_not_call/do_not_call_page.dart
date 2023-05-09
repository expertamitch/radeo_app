import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class DoNotCallPage extends StatefulWidget {
  const DoNotCallPage({Key? key}) : super(key: key);

  @override
  State<DoNotCallPage> createState() => _DoNotCallPageState();
}

class _DoNotCallPageState extends State<DoNotCallPage> {
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
            child: Text(
              'Do Not Call',
              style: w700_30(),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return doNotCallListTile(
                      dateTime: DateTime.now(),
                      location:
                          '2006 Chapmans Lane, San Francisc 2006 Chapmans Lane, San Franciscoo…',
                      leadingIconPath: Images.locationIcon,
                    );
                  }))
        ]));
  }

  doNotCallListTile({
    required DateTime dateTime,
    required String location,
    required String leadingIconPath,
  }) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.borderGreyColor))),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ImageView(
              path: leadingIconPath,
              color: AppColors.purpleColor,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: w600_14(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(dateTime),
                      style: w500_12(color: Colors.grey),
                    ),
                    Text(
                      'Do Not Call',
                      style: w500_12(color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
