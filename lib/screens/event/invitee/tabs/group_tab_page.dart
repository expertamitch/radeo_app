import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/image_view.dart';

class GroupTabPage extends StatefulWidget {
  const GroupTabPage({Key? key}) : super(key: key);

  @override
  State<GroupTabPage> createState() => _GroupTabPageState();
}

class _GroupTabPageState extends State<GroupTabPage> {
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
                  '23 Groups',
                  style: w900_15(),
                ),
                Text(
                  'Select All',
                  style: w600_14(color: AppColors.purpleColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(8)),
            // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  style: w500_14(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: w500_14(
                        color: AppColors.dark2GreyColor,
                      ),
                      hintText: 'Serach Group...',
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
                return groupsTile('Group Name A', '34 Members');
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
        vertical: 10,
        horizontal: 18,
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.greyColor))),
      child: Row(children: [
        SvgPicture.asset(
          Images.groupPeopleIcon,
          height: 25,
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: w400_15(),
            ),
            Text(
              subTitle,
              style: w400_12(
                color: AppColors.dark2GreyColor,
              ),
            )
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 15.w,
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
