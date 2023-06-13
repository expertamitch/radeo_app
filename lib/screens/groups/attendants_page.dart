import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/invite/controller/invite_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/tiles/attendant_tile.dart';

import '../../assets/images.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/image_view.dart';

class AttendantsPage extends StatefulWidget {
  const AttendantsPage({Key? key}) : super(key: key);

  @override
  State<AttendantsPage> createState() => _AttendantsPageState();
}

class _AttendantsPageState extends State<AttendantsPage> {
  InviteController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100))
        .then((value) => controller.createAttendantList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Attendants',
            style: w900_18(),
          ),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Select Attendants',
              style: w900_18(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.darkGreyColor,
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      hintStyle: w300_12(
                        color: AppColors.dark2GreyColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Coordinator…',
                      isDense: true),
                ))
              ],
            ),
          ),
          Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: controller.attendants.value.length,
                  itemBuilder: (context, index) {
                    return AttendantTile(
                      model: controller.attendants.value[index],
                      onTap: () {
                        if (!controller.attendants.value[index].selected) {
                          controller.attendants.value.forEach((element) {
                            element.selected = false;
                          });
                          controller.attendants.value[index].selected = true;
                          setState(() {});
                        }
                      },
                    );
                  })))
        ]));
  }
}
