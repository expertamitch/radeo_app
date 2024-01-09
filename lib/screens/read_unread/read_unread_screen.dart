import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/styling/font_style_globle.dart';
import 'package:redeo/widgets/image_view.dart';

import '../../widgets/common_app_bar.dart';

class ReadUnreadScreen extends StatefulWidget {
  @override
  _ReadUnreadScreenState createState() => _ReadUnreadScreenState();
}

class _ReadUnreadScreenState extends State<ReadUnreadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Read Unread',
        ),
        body: Column(children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (c, i) {
                  return getItem(i == 1);
                },
                separatorBuilder: (c, i) {
                  return Divider(
                    color: Color(0XFFEFEFEF),
                  );
                },
                itemCount: 5),
          )
        ]));
  }

  Widget getItem(bool isRead) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          ImageView(
            path: Images.icLocation,
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            children: [Text('263 Roane Avenue, Houston, Texas 77011', style: w600_16(color: Colors.black),)],
          )
        ],
      ),
    );
  }
}
