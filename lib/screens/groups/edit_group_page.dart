import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/models/all_group_list_response_model.dart';
import 'package:redeo/screens/groups/controller/groups_controller.dart';
import 'package:redeo/screens/groups/select_attendant_bottom_sheet.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../models/local_attendant_model.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/validators.dart';
import '../invite/controller/invite_controller.dart';
import 'remove_users_bottom_sheet.dart';

class EditGroupPage extends StatefulWidget {
  const EditGroupPage({Key? key}) : super(key: key);

  @override
  State<EditGroupPage> createState() => _EditGroupPageState();
}

class _EditGroupPageState extends State<EditGroupPage> {
  GroupModel data = Get.arguments;
  late GroupModel model;

  InviteController inviteController = Get.put(
    InviteController(),
    permanent: false,
  );
  GroupsController groupsController = Get.find();
  TextEditingController groupNameController = TextEditingController();

  check() {
    if (keepChecking) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        isValid.value =
            (Validators.validateName(groupNameController.text) == null &&
                model.users!.length > 1 &&
                attendant != null);
        setState(() {});
        check();
      });
    }
  }

  RxBool isValid = false.obs;
  bool keepChecking = true;
  int count = 0;
  UserData? attendant;

  @override
  void initState() {
    model = GroupModel.clone(data);
    groupNameController.text = model.groupName ?? '';

    check();

    reCal();

    super.initState();
  }

  reCal() {
    count = 0;
    attendant = null;
    model.users!.forEach((element) {
      element.users!.forEach((element1) {
        if (element1.isAttendent) attendant = element1;

        count++;
      });
    });

    if (attendant == null)
      inviteController.tempGroupsList
          .where((p) => p.selected)
          .forEach((element) {
        element.users!.forEach((p0) {
          p0.users!.forEach((p1) {
            if (p1.isAttendent) {
              attendant = UserData(
                  mobile: p1.mobile,
                  firstName: p1.firstName,
                  lastName: p1.lastName,
                  isAttendent: true,
                  contact_type: p1.contact_type,
                  from_group_id: p1.from_group_id);
            }
          });
        });
      });

    if (attendant == null)
      inviteController.tempContactsList
          .where((p) => p.selected)
          .forEach((element) {
        if (element.isAttendant)
          attendant = UserData(
            mobile: element.phoneContact.phones[0].number,
            firstName: element.phoneContact.name.first,
            lastName: element.phoneContact.name.last,
            isAttendent: true,
            contact_type: 'phone',
          );
      });

    if (attendant == null)
      inviteController.redeoList.where((p) => p.selected).forEach((element) {
        if (element.isAttendant) {
          attendant = UserData(
            mobile: element.mobile,
            firstName: element.firstName,
            lastName: element.lastName,
            isAttendent: true,
            contact_type: 'redeo',
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            if (model.isEditing)
              Row(
                children: [
                  Obx(() => AppButton(
                      onPressedFunction: () async {
                        if (isValid.value) {
                          Map<String, dynamic> data = {};
                          data['group_name'] = groupNameController.text;
                          List<Map<String, dynamic>> usersArray = [];

                          model.users!.forEach((p0) {
                            p0.users!.forEach((element) {
                              usersArray.add({
                                'name':
                                    "${element.firstName ?? ''} ${element.lastName ?? ''}",
                                'mobile': element.mobile ?? '',
                                'contact_type': element.contact_type,
                                'is_attendent': element.isAttendent
                              });
                            });
                          });
                          inviteController.tempGroupsList.where((p9) => p9.selected).forEach((p0) {
                            p0.users!.forEach((element) {
                              element.users!.forEach((p2) {
                                usersArray.add({
                                  'name':
                                      "${p2.firstName ?? ''} ${p2.lastName ?? ''}",
                                  'mobile': p2.mobile ?? '',
                                  'contact_type': element.contactType,
                                  'is_attendent': p2.isAttendent
                                });
                              });
                            });
                          });

                          inviteController.tempRedeoList.where((p9) => p9.selected).forEach((p0) {
                            usersArray.add({
                              'name':
                                  "${p0.firstName ?? ''} ${p0.lastName ?? ''}",
                              'mobile': p0.mobile ?? '',
                              'contact_type': 'redeo',
                              'is_attendent': p0.isAttendant
                            });
                          });

                          inviteController.tempContactsList.where((p9) => p9.selected).forEach((p0) {
                            usersArray.add({
                              'name':
                                  "${p0.phoneContact.name.first ?? ''} ${p0.phoneContact.name.last ?? ''}",
                              'mobile': p0.phoneContact.phones[0].number ?? '',
                              'contact_type': 'phone',
                              'is_attendent': p0.isAttendant
                            });
                          });

                          data['group_users'] = usersArray;

                          var success = await groupsController.updateGroup(
                              data, model.id.toString());
                          if (success) {
                            groupsController.getGroupsList();
                            Get.back();
                          }
                        }
                      },
                      child: Text(
                        'Save',
                        style: w300_12(color: Colors.white),
                      ),
                      height: 30.h,
                      sodiumShapeBorder: true,
                      width: null,
                      buttonColor: isValid.value
                          ? AppColors.purpleColor
                          : Colors.black26))
                ],
              ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
            child: Text(
              model.isEditing ? 'Edit Group' : 'View Group',
              style: w900_30(),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Group Name',
              style: w300_13(
                color: AppColors.blueColor,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
              style: w300_13(),
              enabled: model.isEditing,
              controller: groupNameController,
              decoration: InputDecoration(
                  hintStyle: w300_13(),
                  hintText: 'Group Name',
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Divider(
            thickness: 1,
            color: AppColors.greyColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Group Members',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      '${count + inviteController.selectedMembersCount.value} Members selected',
                      style: w600_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 18.w,
              ),
              if (model.isEditing)
                AppButton(
                    onPressedFunction: () {
                      showRemoveUsersBottomSheet(model.users!).then((value) {
                        if (value != null) {
                          model.users = value;
                          setState(() {});
                        }
                        reCal();
                      });
                    },
                    child: Text(
                      'Remove',
                      style: w300_13(color: Colors.white),
                    ),
                    sodiumShapeBorder: true,
                    width: null,
                    height: 30.h,
                    buttonColor: AppColors.purpleColor),
              SizedBox(
                width: 8.w,
              ),
              if (model.isEditing)
                AppButton(
                    onPressedFunction: () {
                      Get.toNamed(Routes.inviteeScreen);
                    },
                    child: Text(
                      'Add',
                      style: w300_13(color: Colors.white),
                    ),
                    sodiumShapeBorder: true,
                    width: null,
                    height: 30.h,
                    buttonColor: AppColors.purpleColor),
              SizedBox(
                width: 18.w,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            thickness: 1,
            color: AppColors.greyColor,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Group Attendant',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      attendant == null
                          ? ''
                          : ((attendant!.firstName ?? '') +
                              ' ' +
                              (attendant!.lastName ?? '')),
                      style: w600_13(
                        color: AppColors.blueColor,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 18.w,
                ),
              ),
              if (model.isEditing)
                AppButton(
                    onPressedFunction: () {
                      showSelectAttendantBottomSheet(model.users!)
                          .then((value) {
                        if (value != null) {
                          model.users!.forEach((element) {
                            element.users!.forEach((p0) {
                              p0.isAttendent = false;
                            });
                          });

                          inviteController.tempGroupsList.forEach((element) {
                            element.users!.forEach((p0) {
                              p0.users!.forEach((p1) {
                                p1.isAttendent = false;
                              });
                            });
                          });

                          inviteController.tempRedeoList.forEach((element) {
                            element.isAttendant = false;
                          });
                          inviteController.tempContactsList.forEach((element) {
                            element.isAttendant = false;
                          });

                          LocalAttendantModel m = value;
                          bool sel = false;

                          model.users!.forEach((element) {
                            element.users!.forEach((p0) {
                              if (p0.mobile == m.phone) {
                                sel = true;
                                p0.isAttendent = true;
                              }
                            });
                          });

                          if (!sel)
                            inviteController.tempGroupsList.forEach((element) {
                              element.users!.forEach((p0) {
                                p0.users!.forEach((p1) {
                                  if (p1.mobile == m.phone) {
                                    sel = true;
                                    p1.isAttendent = true;
                                  }
                                });
                              });
                            });

                          if (!sel)
                            inviteController.tempContactsList
                                .forEach((element) {
                              if (element.phoneContact.phones[0].number ==
                                  m.phone) {
                                sel = true;
                                element.isAttendant = true;
                              }
                            });

                          if (!sel)
                            inviteController.redeoList.forEach((element) {
                              if (element.mobile == m.phone) {
                                sel = true;
                                element.isAttendant = true;
                              }
                            });

                          attendant = UserData(
                              isAttendent: true,
                              id: 1,
                              firstName: m.name,
                              mobile: m.phone,
                              contact_type: m.type,
                              from_group_id:
                                  m.type == 'group' ? m.from_group_id : null);
                          setState(() {});
                        }
                        reCal();
                      });
                    },
                    child: Text(
                      'Select',
                      style: w300_13(color: Colors.white),
                    ),
                    sodiumShapeBorder: true,
                    width: null,
                    height: 30.h,
                    buttonColor: AppColors.purpleColor),
              SizedBox(
                width: 18.w,
              ),
            ],
          )
        ]));
  }

  @override
  void dispose() {
    keepChecking = false;
    super.dispose();
  }
}
