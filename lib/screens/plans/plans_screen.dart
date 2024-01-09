import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../../widgets/common_app_bar.dart';

class PlansScreen extends StatefulWidget {
  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Subscription Plans',
        ),
        body: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 26.h),
                itemBuilder: (c, i) {
                  return getItem(i == 1);
                },
                separatorBuilder: (c, i) {
                  return Container(
                    height: 15.h,
                  );
                },
                itemCount: 5),
          )
        ]));
  }

  Widget getItem(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0XFFF1F4F8), borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.only(top: 8.h, bottom: 8.h, left: 16.w, right: 18.w),
            decoration: BoxDecoration(
                color: isActive ? Color(0XFF74167B) : Color(0XFF1F1F1F),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PLAN A',
                      style: w600_13(color: Colors.white),
                    ),
                    if (isActive)
                      SizedBox(
                        height: 4,
                      ),
                    if (isActive)
                      Text(
                        'Active Now',
                        style: w300_11(color: Colors.white),
                      )
                  ],
                ),
                Spacer(),
                Text(
                  '\$00.00',
                  style: w900_25(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: 16.h, bottom: 14.h, left: 16.w, right: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '10 Video uploads, 50 QR code',
                  style: w300_13(color: Color(0XFF73BAD9)),
                ),
                SizedBox(
                  height: 23,
                ),
                Text(
                  '- Bullet points 1',
                  style: w300_11(color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '- Bullet points 1',
                  style: w300_11(color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '- Bullet points 1',
                  style: w300_11(color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '- Bullet points 1',
                  style: w300_11(color: Colors.black),
                ),
                if (!isActive)
                  Container(
                    margin: EdgeInsets.only(top: 14.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    width: Get.width,
                    alignment: Alignment.center,
                    child: Text('Buy Now', style: w300_11(),),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
