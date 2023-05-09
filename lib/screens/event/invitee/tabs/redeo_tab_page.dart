import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../assets/images.dart';
import '../../../../styling/app_colors.dart';
import '../../../../styling/font_style_globle.dart';
import '../../../../widgets/app_text.dart';
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
                Text(
                  'Select All',
                  style: w600_14(color: AppColors.purpleColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
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
                SizedBox(width: 15),
                Flexible(
                    child: TextFormField(
                  style: w300_14(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Serach Redeo Contact',
                      hintStyle: w300_14(
                        color: AppColors.dark2GreyColor,
                      ),
                      isDense: true),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
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
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.greyColor))),
      child: Row(children: [
        SvgPicture.asset(
          Images.peopleIcon,
          height: 25,
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: title,
              textSize: 16,
            ),
            AppText(
              text: subTitle,
              color: AppColors.dark2GreyColor,
              textSize: 12,
            )
          ],
        ),
        Expanded(
          child: SizedBox(
            width: 5,
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
