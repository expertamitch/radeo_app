import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';

import '../../../../widgets/image_view.dart';

class RedeoTabPage extends StatefulWidget {
  const RedeoTabPage({Key? key}) : super(key: key);

  @override
  State<RedeoTabPage> createState() => _RedeoTabPageState();
}

class _RedeoTabPageState extends State<RedeoTabPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '23 Redeo Contact',
                  style: w900_15(),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 18),
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
                  style: w300_12(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Redeo Contact',
                      hintStyle: w300_12(
                        color: AppColors.dark2GreyColor,
                      ),
                      isDense: true),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return groupsTile('Redeo Name A', '34 Members');
              },
            ),
          )
        ],
      ),
    );
  }

  groupsTile(String title, String subTitle) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.greyColor))),
      child: Row(children: [
        SvgPicture.asset(
          Images.peopleIcon,
          height: 23,
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: w300_12(),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              subTitle,
              style: w300_10(
                color: AppColors.dark2GreyColor,
              ),
            )
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 5.w,
          ),
        ),
        Radio(
          value: false,
          groupValue: 'groupValue',
          onChanged: (value) {},
        )
      ]),
    );
  }
}