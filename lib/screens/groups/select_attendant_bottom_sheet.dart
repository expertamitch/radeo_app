import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/screens/invite/controller/invite_controller.dart';

import '../../models/all_group_list_response_model.dart';
import '../../models/all_redeo_member_list_response_model.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet_widget.dart';
import '../../widgets/radio_selection_widget.dart';

Future showSelectAttendantBottomSheet(GroupModel users) {
  return Get.bottomSheet(
    BottomSheetWidget(
      child: SelectAttendantScreen(model: users),
    ),
    isScrollControlled: true,
  );
}

class SelectAttendantScreen extends StatefulWidget {
  GroupModel model;

  SelectAttendantScreen({required this.model});

  @override
  _SelectAttendantScreenState createState() => _SelectAttendantScreenState();
}

class _SelectAttendantScreenState extends State<SelectAttendantScreen> {
  List<Users> cloneUsers = [];
  List<int> redeoSelectedIndex = [];
  List<int> phoneSelectedIndex = [];
  Map<int, Map<String, List<int>>> groupSelectedIndex = {};
  InviteController inviteController = Get.find();

  @override
  void initState() {
    cloneUsers = widget.model.users!.map((e) => Users.clone(e)).toList();
    List<UserData> tmpGroups = [];
    inviteController.tempGroupsList.forEach((element) {
      if (element.selected) {
        element.users!.forEach((p0) {
          tmpGroups.addAll(p0.users!);
        });
      }
    });

    for (int i = 0;
        i <
            inviteController.redeoList
                .where((element) => element.selected)
                .toList()
                .length;
        i++) {
      if (inviteController.redeoList
          .where((element) => element.selected)
          .toList()[i]
          .isAttendant) redeoSelectedIndex.add(i);
    }

    for (int i = 0;
        i <
            inviteController.contacts
                .where((element) => element.selected)
                .toList()
                .length;
        i++) {
      if (inviteController.contacts
          .where((element) => element.selected)
          .toList()[i]
          .isAttendant) phoneSelectedIndex.add(i);
    }

    for (int i = 0;
        i <
            inviteController.groupsList
                .where((element) => element.selected)
                .toList()
                .length;
        i++) {
      inviteController.groupsList
          .where((group) => group.selected)
          .toList()[i]
          .users!
          .forEach((element) {
        element.users!.asMap().entries.forEach((data) {
          if (data.value.isLocalAttendant) {
            {
              int groupId = (inviteController.groupsList
                  .where((group) => group.selected)
                  .toList()[i]
                  .id!);
              if (!groupSelectedIndex.containsKey(groupId))
                groupSelectedIndex.putIfAbsent(groupId, () => {});

              if (!groupSelectedIndex[groupId]!
                  .containsKey(data.value.contact_type!))
                groupSelectedIndex[groupId]!
                    .putIfAbsent(data.value.contact_type!, () => []);

              groupSelectedIndex[groupId]![data.value.contact_type!]!.add(data.key);
            }
          }
        });
      });
    }
    print(groupSelectedIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height - 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: cloneUsers[0]
                              .users!
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
                          children: cloneUsers[1]
                              .users!
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
                          children: cloneUsers[2]
                              .users!
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
                          children: [
                            for (int i = 0;
                                i <
                                    inviteController.redeoList
                                        .where((element) => element.selected)
                                        .toList()
                                        .length;
                                i++)
                              getItem(
                                  e: inviteController.redeoList
                                      .where((element) => element.selected)
                                      .toList()[i],
                                  name:
                                      "${inviteController.redeoList.where((element) => element.selected).toList()[i].firstName} ${inviteController.redeoList.where((element) => element.selected).toList()[i].lastName ?? ''}",
                                  mobile: inviteController.redeoList
                                          .where((element) => element.selected)
                                          .toList()[i]
                                          .mobile ??
                                      '',
                                  selected: redeoSelectedIndex.contains(i),
                                  onTap: () {
                                    if (redeoSelectedIndex.contains(i))
                                      redeoSelectedIndex.remove(i);
                                    else
                                      redeoSelectedIndex.add(i);

                                    setState(() {});
                                  })
                          ],
                        ),
                        Column(
                          children: [
                            for (int i = 0;
                                i <
                                    inviteController.contacts
                                        .where((element) => element.selected)
                                        .toList()
                                        .length;
                                i++)
                              getItem(
                                  e: inviteController.contacts
                                      .where((element) => element.selected)
                                      .toList()[i],
                                  name:
                                      "${inviteController.contacts.where((element) => element.selected).toList()[i].phoneContact.name.first} ${inviteController.contacts.where((element) => element.selected).toList()[i].phoneContact.name.last ?? ''}",
                                  mobile: inviteController.contacts
                                          .where((element) => element.selected)
                                          .toList()[i]
                                          .phoneContact
                                          .phones[0]
                                          .number ??
                                      '',
                                  selected: phoneSelectedIndex.contains(i),
                                  onTap: () {
                                    if (phoneSelectedIndex.contains(i))
                                      phoneSelectedIndex.remove(i);
                                    else
                                      phoneSelectedIndex.add(i);

                                    setState(() {});
                                  })
                          ],
                        ),
                        Column(
                          children: inviteController.groupsList
                              .where((groupModel) => groupModel.selected)
                              .toList()
                              .map((el) => Column(
                            children: el.users!
                                .map((data) => Column(
                              children: data.users!.asMap().entries

                                  .map((e) => getItem(
                                  e: e,
                                  name:
                                  "${e.value.firstName} ${e.value.lastName ?? ''}",
                                  mobile: e.value.mobile ?? '',
                                  selected:groupSelectedIndex.containsKey(el.id) && groupSelectedIndex[el.id!]!.containsKey(e.value.contact_type!) && groupSelectedIndex[el.id!]![e.value.contact_type!]!.contains(e.key),
                                  onTap: () {
                                    if(groupSelectedIndex.containsKey(el.id) && groupSelectedIndex[el.id!]!.containsKey(e.value.contact_type!) && groupSelectedIndex[el.id!]![e.value.contact_type!]!.contains(e.key)){
                                    //  already selected
                                      groupSelectedIndex[el.id!]![e.value.contact_type!]!.remove(e.key);
                                    }else
                                      {
                                        int groupId = el.id!;
                                        if (!groupSelectedIndex.containsKey(groupId))
                                          groupSelectedIndex.putIfAbsent(groupId, () => {});

                                        if (!groupSelectedIndex[groupId]!
                                            .containsKey(e.value.contact_type!))
                                          groupSelectedIndex[groupId]!
                                              .putIfAbsent(e.value.contact_type!, () => []);

                                        groupSelectedIndex[groupId]![e.value.contact_type!]!.add(e.key);
                                      }
                                    setState(() {});
                                  }))
                                  .toList(),
                            ))
                                .toList(),
                          ))
                              .toList(),
                        )

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppButton(
                    onPressedFunction: () async {

                      for (int i = 0;
                          i <
                              inviteController.redeoList
                                  .where((element) => element.selected)
                                  .toList()
                                  .length;
                          i++) {
                        if (redeoSelectedIndex.contains(i))
                          inviteController.redeoList
                              .where((element) => element.selected)
                              .toList()[i]
                              .isAttendant = true;
                        else
                          inviteController.redeoList
                              .where((element) => element.selected)
                              .toList()[i]
                              .isAttendant = false;
                      }

                      for (int i = 0;
                          i <
                              inviteController.contacts
                                  .where((element) => element.selected)
                                  .toList()
                                  .length;
                          i++) {
                        if (phoneSelectedIndex.contains(i))
                          inviteController.contacts
                              .where((element) => element.selected)
                              .toList()[i]
                              .isAttendant = true;
                        else
                          inviteController.contacts
                              .where((element) => element.selected)
                              .toList()[i]
                              .isAttendant = false;
                      }




                      for (int i = 0;
                      i <
                          inviteController.groupsList
                              .where((element) => element.selected)
                              .toList()
                              .length;
                      i++) {
                        inviteController.groupsList
                            .where((group) => group.selected)
                            .toList()[i]
                            .users!
                            .forEach((element) {
                          element.users!.asMap().entries.forEach((data) {


                            int groupId = (inviteController.groupsList
                                .where((group) => group.selected)
                                .toList()[i]
                                .id!);

                            if(groupSelectedIndex.containsKey(groupId) && groupSelectedIndex[groupId]!.containsKey(data.value.contact_type!) && groupSelectedIndex[groupId]![data.value.contact_type!]!.contains(data.key)){
                              data.value.isLocalAttendant=true;
                            }
                            else
                              data.value.isLocalAttendant=false;

                          });
                        });
                      }





                      inviteController.tempRedeoList
                          .where((p0) => p0.selected)
                          .map((e) => ContactInfo.clone(e))
                          .toList();

                      widget.model.users = cloneUsers;
                      Get.back(result: widget.model);
                    },
                    child: Text(
                      'Select',
                      style: w900_15(color: Colors.white),
                    ),
                    height: 50.h,
                    buttonColor: AppColors.purpleColor),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getItem(
      {required dynamic e,
      required String name,
      required String mobile,
      required bool selected,
      int? index,
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
                "${index ?? ''} $name",
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
