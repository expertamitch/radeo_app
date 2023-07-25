import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/screens/invite/controller/invite_controller.dart';

import '../../models/all_group_list_response_model.dart';
import '../../models/all_redeo_member_list_response_model.dart';
import '../../models/local_attendant_model.dart';
import '../../models/phone_contact_model.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet_widget.dart';
import '../../widgets/radio_selection_widget.dart';

Future showSelectAttendantBottomSheet(List<Users> users) {
  return Get.bottomSheet(
    BottomSheetWidget(
      child: SelectAttendantScreen(tUsers: users),
    ),
    isScrollControlled: true,
  );
}

class SelectAttendantScreen extends StatefulWidget {
  List<Users> tUsers;

  SelectAttendantScreen({required this.tUsers});

  @override
  _SelectAttendantScreenState createState() => _SelectAttendantScreenState();
}

class _SelectAttendantScreenState extends State<SelectAttendantScreen> {
  List<Users> cloneUsers = [];
  List<UserData> cloneGroups = [];
  List<PhoneContactModel> clonePhoneContacts = [];
  List<Info> cloneRedeoContacts = [];

  InviteController inviteController = Get.find();

  LocalAttendantModel? lam;

  @override
  void initState() {
    cloneUsers = widget.tUsers.map((e) => Users.clone(e)).toList();
    List<UserData> tmpGroups = [];
    inviteController.tempGroupsList.forEach((element) {
      if (element.selected) {
        element.users!.forEach((p0) {
          tmpGroups.addAll(p0.users!);
        });
      }
    });

    cloneGroups = tmpGroups.map((element) => UserData.clone(element)).toList();
    cloneGroups.forEach((element) {
      element.selected = false;
    });

    cloneRedeoContacts = inviteController.tempRedeoList
        .where((p0) => p0.selected)
        .map((e) => Info.clone(e))
        .toList();
    cloneRedeoContacts.forEach((element) {
      element.selected = false;
    });

    clonePhoneContacts = inviteController.tempContactsList
        .where((p0) => p0.selected)
        .map((e) => PhoneContactModel.clone(e))
        .toList();
    clonePhoneContacts.forEach((element) {
      element.selected = false;
    });

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
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      rbTap(e);
                                      if (e.selected) {
                                        lam = LocalAttendantModel(
                                            index: 0,
                                            selected: false,
                                            phone: e.mobile!,
                                            name:
                                                "${e.firstName ?? ''} ${e.lastName ?? ''}",
                                            type: e.contact_type!,
                                            from_group_id:
                                                e.contact_type == 'group'
                                                    ? e.from_group_id
                                                    : null);
                                      } else
                                        lam = null;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.greyColor))),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          Images.peopleIcon,
                                          height: 23,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.firstName} ${e.lastName ?? ''}",
                                              style: w300_12(),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              e.mobile ?? '',
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
                                        RadioSelectionWidget(
                                            selected: e.selected),
                                      ]),
                                    ),
                                  ))
                              .toList(),
                        ),
                        Column(
                          children: cloneUsers[1]
                              .users!
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      rbTap(e);
                                      if (e.selected) {
                                        lam = LocalAttendantModel(
                                            index: 1,
                                            selected: false,
                                            phone: e.mobile!,
                                            name:
                                                "${e.firstName ?? ''} ${e.lastName ?? ''}",
                                            type: e.contact_type!,
                                            from_group_id:
                                                e.contact_type == 'group'
                                                    ? e.from_group_id
                                                    : null);
                                      } else
                                        lam = null;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.greyColor))),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          Images.peopleIcon,
                                          height: 23,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.firstName} ${e.lastName ?? ''}",
                                              style: w300_12(),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              e.mobile ?? '',
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
                                        RadioSelectionWidget(
                                            selected: e.selected),
                                      ]),
                                    ),
                                  ))
                              .toList(),
                        ),
                        Column(
                          children: cloneUsers[2]
                              .users!
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      rbTap(e);
                                      if (e.selected) {
                                        lam = LocalAttendantModel(
                                            index: 2,
                                            selected: false,
                                            phone: e.mobile!,
                                            name:
                                                "${e.firstName ?? ''} ${e.lastName ?? ''}",
                                            type: e.contact_type!,
                                            from_group_id:
                                                e.contact_type == 'group'
                                                    ? e.from_group_id
                                                    : null);
                                      } else
                                        lam = null;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.greyColor))),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          Images.peopleIcon,
                                          height: 23,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.firstName} ${e.lastName ?? ''}",
                                              style: w300_12(),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              e.mobile ?? '',
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
                                        RadioSelectionWidget(
                                            selected: e.selected),
                                      ]),
                                    ),
                                  ))
                              .toList(),
                        ),
                        Column(
                          children: cloneRedeoContacts
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      rbTap(e);
                                      if (e.selected) {
                                        lam = LocalAttendantModel(
                                          index: 3,
                                          selected: false,
                                          phone: e.mobile!,
                                          name:
                                              "${e.firstName ?? ''} ${e.lastName ?? ''}",
                                          type: 'redeo',
                                        );
                                      } else
                                        lam = null;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.greyColor))),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          Images.peopleIcon,
                                          height: 23,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.firstName} ${e.lastName ?? ''}",
                                              style: w300_12(),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              e.mobile ?? '',
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
                                        RadioSelectionWidget(
                                            selected: e.selected),
                                      ]),
                                    ),
                                  ))
                              .toList(),
                        ),
                        Column(
                          children: clonePhoneContacts
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      rbTap(e);
                                      if (e.selected) {
                                        lam = LocalAttendantModel(
                                          index: 4,
                                          selected: false,
                                          phone:
                                              e.phoneContact.phones[0].number,
                                          name:
                                              "${e.phoneContact.name.first ?? ''} ${e.phoneContact.name.last ?? ''}",
                                          type: 'phone',
                                        );
                                      } else
                                        lam = null;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.greyColor))),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          Images.peopleIcon,
                                          height: 23,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.phoneContact.name.first} ${e.phoneContact.name.last ?? ''}",
                                              style: w300_12(),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              e.phoneContact.phones[0].number ??
                                                  '',
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
                                        RadioSelectionWidget(
                                            selected: e.selected),
                                      ]),
                                    ),
                                  ))
                              .toList(),
                        ),
                        Column(
                          children: cloneGroups
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      rbTap(e);
                                      if (e.selected) {
                                        lam = LocalAttendantModel(
                                            index: 5,
                                            selected: false,
                                            phone: e.mobile!,
                                            name:
                                                "${e.firstName ?? ''} ${e.lastName ?? ''}",
                                            type: e.contact_type!,
                                            from_group_id:
                                                e.contact_type == 'group'
                                                    ? e.from_group_id
                                                    : null);
                                      } else
                                        lam = null;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: AppColors.greyColor))),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          Images.peopleIcon,
                                          height: 23,
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${e.firstName} ${e.lastName ?? ''}",
                                              style: w300_12(),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              e.mobile ?? '',
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
                                        RadioSelectionWidget(
                                            selected: e.selected),
                                      ]),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppButton(
                    onPressedFunction: () async {
                      Get.back(result: lam);
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

  rbTap(var e) {
    if (!e.selected) {
      cloneUsers.forEach((element) {
        element.users!.forEach((p0) {
          p0.selected = false;
        });
      });
      cloneGroups.forEach((element) {
        element.selected = false;
      });
      clonePhoneContacts.forEach((element) {
        element.selected = false;
      });
      cloneRedeoContacts.forEach((element) {
        element.selected = false;
      });
      e.selected = true;
    } else {
      e.selected = false;
    }

    setState(() {});
  }
}
