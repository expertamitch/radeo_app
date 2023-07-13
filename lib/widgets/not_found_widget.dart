import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:redeo/styling/font_style_globle.dart';

import '../assets/images.dart';

class NotFoundWidget extends StatelessWidget {
  String? title;

  NotFoundWidget({this.title});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            Images.notFound,
            width: Get.width * 0.5,

          ),
          if(title!=null)
          Text(title!, style: w300_12(),)
        ],
      ),
    );
  }
}
