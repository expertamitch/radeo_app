import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/models/local_attendant_model.dart';
import 'package:redeo/screens/groups/controller/groups_controller.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/validators.dart';
import '../invite/controller/invite_controller.dart';

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  InviteController inviteController = Get.put(
    InviteController(),
    permanent: false,
  );
  GroupsController groupsController = Get.find();
  TextEditingController groupNameController = TextEditingController();
  int l=0;

  check() {
    if (keepChecking) {


      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        isValid.value =
              (Validators.validateName(groupNameController.text) == null &&
                inviteController.selectedMembersCount.value > 0 &&
                l>0);
        setState(() {});
        check();
      });
    }
  }

  RxBool isValid = false.obs;
  bool keepChecking = true;

  @override
  void initState() {
    inviteController.redeoList.where((element) => element.selected).forEach((e) {
      e.isAttendant=false;
      e.isVisible=true;

    });

    inviteController.contacts.where((element) => element.selected).forEach((e) {
      e.isAttendant=false;
      e.isVisible=true;
    });

    inviteController.groupsList
        .where((element) => element.selected)
        .forEach((element) {
      element.users!.forEach((users) {
        users.users!.forEach((e) {
          e.isLocalAttendant=false;
          e.isVisible=true;
        });
      });
    });


    check();





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
          actions: [
            Row(
              children: [
                Obx(() => AppButton(
                    onPressedFunction: () async {
                      if (isValid.value) {
                        Map<String, dynamic> data = {};
                        data['group_name'] = groupNameController.text;
                        List<Map<String, dynamic>> usersArray = [];

                        inviteController.groupsList
                            .where((p0) => p0.selected)
                            .forEach((element) {
                          element.users?.forEach((element1) {
                            if (element1.users!.length > 0) {
                              element1.users!.forEach((data) {
                                usersArray.add({
                                  'name':
                                      "${data.firstName ?? ''} ${data.lastName ?? ''}",
                                  'mobile': data.mobile ?? '',
                                  'contact_type': 'group',
                                  'is_attendent': data.isLocalAttendant,
                                  'from_group_id':
                                      element1.contactType == 'group'
                                          ? data.from_group_id
                                          : null,
                                  'contact_type': element1.contactType
                                });
                              });
                            }
                          });
                        });

                        inviteController.redeoList
                            .where((p0) => p0.selected)
                            .forEach((element) {
                          if (element.selected)
                            usersArray.add({
                              'name':
                                  "${element.firstName ?? ''} ${element.lastName ?? ''}",
                              'mobile': element.mobile ?? '',
                              'is_attendent': element.isAttendant,

                              'contact_type': 'redeo',
                            });
                        });

                        inviteController.contacts
                            .where((p0) => p0.selected)
                            .forEach((element) {
                          if (element.selected)
                            usersArray.add({
                              'is_attendent': element.isAttendant,

                              'name':
                                  "${element.phoneContact.name.first ?? ''} ${element.phoneContact.name.last ?? ''}",
                              'mobile':
                                  element.phoneContact.phones[0].number ?? '',
                              'contact_type': 'phone',
                            });
                        });



                        data['group_users'] = usersArray;

                        var success = await groupsController.createGroup(data);
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
                    buttonColor:
                        isValid.value ? AppColors.purpleColor : Colors.black26))
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
              'Create Group',
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
                      'Select Member',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => Text(
                        '${inviteController.selectedMembersCount.value} Members selected',
                        style: w600_13(
                          color: AppColors.blueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 18.w,
                ),
              ),
              AppButton(
                  onPressedFunction: () async {
                    await Get.toNamed(Routes.inviteeScreen);
                    calculateAttendants();

                    inviteController.tempAttendantsList.value.clear();
                    setState(() {

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
                      'Select Attendants',
                      style: w300_13(
                        color: AppColors.blueColor,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),Text(
                      '$l Attendants selected',
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
              AppButton(
                  onPressedFunction: () async {
                    await Get.toNamed(Routes.attendantsScreen);
calculateAttendants();
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

  calculateAttendants(){
    l=0;
    inviteController.redeoList.where((element) => element.selected).forEach((e) {
      if(e.isAttendant)
        l++;

    });

    inviteController.contacts.where((element) => element.selected).forEach((e) {
      if(e.isAttendant)
        l++;
    });

    inviteController.groupsList
        .where((element) => element.selected)
        .forEach((element) {
      element.users!.forEach((users) {
        users.users!.forEach((e) {
          if(e.isLocalAttendant)
            l++;
        });
      });
    });
    setState(() {

    });
  }

  @override
  void dispose() {
    keepChecking = false;
    super.dispose();
  }
}
