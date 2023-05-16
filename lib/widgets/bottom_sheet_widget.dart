import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../assets/images.dart';
import 'image_view.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({required this.child,  });

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Stack(
                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: ImageView(
                        path: Images.closeIcon,
                        width: 15.w,
                      ),
                    ),
                  )
                ],
              ),
              child
            ],
          ),
        )
      ],
    );
  }
}
