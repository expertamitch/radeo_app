import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/invite/controller/invite_controller.dart';
import 'package:redeo/styling/app_colors.dart';
import 'package:redeo/widgets/search_widget.dart';
import 'package:redeo/widgets/tiles/attendant_tile.dart';

import '../../assets/images.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/radio_selection_widget.dart';

class AttendantsPage extends StatefulWidget {
  const AttendantsPage({Key? key}) : super(key: key);

  @override
  State<AttendantsPage> createState() => _AttendantsPageState();
}

class _AttendantsPageState extends State<AttendantsPage> {
  InviteController controller = Get.find();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100)).then((value) {

      controller.redeoList.where((element) => element.selected).forEach((e) {
        e.isVisible = true;
      });

      controller.contacts.where((element) => element.selected).forEach((e) {
        e.isVisible = true;
      });

      controller.groupsList
          .where((element) => element.selected)
          .forEach((element) {
        element.users!.forEach((users) {
          users.users!.forEach((e) {
            e.isVisible = true;
          });
        });
      });

      setState(() {});
    });

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
          SearchWidget(
              hint: 'Search Coordinator…',
              onChange: (txt) {
                // controller.executeAttendentSearch

                controller.redeoList
                    .where((element) => element.selected)
                    .forEach((e) {
                  String name = "${e.firstName} ${e.lastName ?? ''}";
                  e.isVisible = name.toLowerCase().contains(txt);
                });

                controller.contacts
                    .where((element) => element.selected)
                    .forEach((e) {
                  String name =
                      "${e.phoneContact.name.first} ${e.phoneContact.name.last ?? ''}";
                  e.isVisible = name.toLowerCase().contains(txt);
                });

                controller.groupsList
                    .where((element) => element.selected)
                    .forEach((element) {
                  element.users!.forEach((users) {
                    users.users!.forEach((e) {
                      String name = "${e.firstName} ${e.lastName ?? ''}";
                      e.isVisible = name.toLowerCase().contains(txt);
                    });
                  });
                });

                setState(() {});
              }),

          getNewList()

          // getOldList()
        ]));
  }

  getNewList() {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: controller.redeoList
                .where((element) => element.selected && element.isVisible)
                .map((e) => getItem(
                    e: e,
                    name: "${e.firstName} ${e.lastName ?? ''}",
                    mobile: e.mobile ?? '',
                    selected: e.isAttendant,
                    onTap: () {
                      e.isAttendant = !e.isAttendant;
                      setState(() {});
                    }))
                .toList(),
          ),
          Column(
            children: controller.contacts
                .where((element) => element.selected && element.isVisible)
                .map((e) => getItem(
                    e: e,
                    name:
                        "${e.phoneContact.name.first} ${e.phoneContact.name.last ?? ''}",
                    mobile: e.phoneContact.phones[0].number ?? '',
                    selected: e.isAttendant,
                    onTap: () {
                      e.isAttendant = !e.isAttendant;
                      setState(() {});
                    }))
                .toList(),
          ),
          Column(
            children: controller.groupsList
                .where((groupModel) => groupModel.selected)
                .toList()
                .map((el) => Column(
                      children: el.users!
                          .map((data) => Column(
                                children: data.users!
                                    .where((element) => element.isVisible)
                                    .map((e) => getItem(
                                        e: e,
                                        name:
                                            "${e.firstName} ${e.lastName ?? ''}",
                                        mobile: e.mobile ?? '',
                                        selected: e.isLocalAttendant,
                                        onTap: () {
                                          e.isLocalAttendant = !e.isLocalAttendant;
                                          setState(() {});
                                        }))
                                    .toList(),
                              ))
                          .toList(),
                    ))
                .toList(),
          ),
        ],
      ),
    ));
  }

  getOldList() {
    return Expanded(
        child: Obx(() => ListView.builder(
            itemCount: controller.tempAttendantsList.value.length,
            itemBuilder: (context, index) {
              return AttendantTile(
                model: controller.tempAttendantsList.value[index],
                onTap: () {
                  if (Get.arguments != null) {
                    Get.back(
                        result: controller.tempAttendantsList.value[index]);
                  } else {
                    controller.tempAttendantsList.value[index].selected =
                        !controller.tempAttendantsList.value[index].selected;
                    setState(() {});
                  }
                },
              );
            })));
  }

  Widget getItem(
      {required dynamic e,
      required String name,
      required String mobile,
      required bool selected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
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
                name,
                style: w300_12(),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                mobile,
                style: w300_10(
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
          RadioSelectionWidget(selected: selected),
        ]),
      ),
    );
  }
}
