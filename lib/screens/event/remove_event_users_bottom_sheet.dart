import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/screens/invite/controller/invite_controller.dart';

import '../../models/all_group_list_response_model.dart';
import '../../models/all_redeo_member_list_response_model.dart';
import '../../models/phone_contact_model.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_button.dart';
import '../../widgets/bottom_sheet_widget.dart';
import '../../widgets/radio_selection_widget.dart';

Future showRemoveEventUsersBottomSheet(List<UserData> users) {
  return Get.bottomSheet(
    BottomSheetWidget(
      child: RemoveUserScreen(tUsers: users),
    ),
    isScrollControlled: true,
  );
}

class RemoveUserScreen extends StatefulWidget {
  List<UserData> tUsers;

  RemoveUserScreen({required this.tUsers});

  @override
  _RemoveUserScreenState createState() => _RemoveUserScreenState();
}

class _RemoveUserScreenState extends State<RemoveUserScreen> {
  List<UserData> cloneUsers = [];
   List<PhoneContactModel> clonePhoneContacts = [];
  List<ContactInfo> cloneRedeoContacts = [];

  InviteController inviteController = Get.find();

  @override
  void initState() {
    cloneUsers = widget.tUsers.map((e) => UserData.clone(e)).toList();


    /*cloneRedeoContacts = inviteController.tempRedeoList
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
    });*/

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
                          children: cloneUsers
                              .map((e) => GestureDetector(
                            onTap: () {  e.selected = !e.selected;
                            setState(() {});},
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
                                      e.name!,
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

                        // Column(
                        //   children: cloneRedeoContacts
                        //       .map((e) => GestureDetector(
                        //             onTap: () {  e.selected = !e.selected;
                        //             setState(() {});},
                        //             child: Container(
                        //               padding: EdgeInsets.symmetric(
                        //                 vertical: 10,
                        //                 horizontal: 20,
                        //               ),
                        //               decoration: BoxDecoration(
                        //                   border: Border(
                        //                       bottom: BorderSide(
                        //                           color: AppColors.greyColor))),
                        //               child: Row(children: [
                        //                 SvgPicture.asset(
                        //                   Images.peopleIcon,
                        //                   height: 23,
                        //                 ),
                        //                 SizedBox(
                        //                   width: 15.w,
                        //                 ),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Text(
                        //                       "${e.firstName} ${e.lastName ?? ''}",
                        //                       style: w300_12(),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 4.h,
                        //                     ),
                        //                     Text(
                        //                       e.mobile ?? '',
                        //                       style: w300_10(
                        //                         color: AppColors.dark2GreyColor,
                        //                       ),
                        //                     )
                        //                   ],
                        //                 ),
                        //                 Expanded(
                        //                   child: SizedBox(
                        //                     width: 15.w,
                        //                   ),
                        //                 ),
                        //                 RadioSelectionWidget(
                        //                     selected: e.selected),
                        //               ]),
                        //             ),
                        //           ))
                        //       .toList(),
                        // ),
                        // Column(
                        //   children: clonePhoneContacts
                        //       .map((e) => GestureDetector(
                        //             onTap: () {  e.selected = !e.selected;
                        //             setState(() {});},
                        //             child: Container(
                        //               padding: EdgeInsets.symmetric(
                        //                 vertical: 10,
                        //                 horizontal: 20,
                        //               ),
                        //               decoration: BoxDecoration(
                        //                   border: Border(
                        //                       bottom: BorderSide(
                        //                           color: AppColors.greyColor))),
                        //               child: Row(children: [
                        //                 SvgPicture.asset(
                        //                   Images.peopleIcon,
                        //                   height: 23,
                        //                 ),
                        //                 SizedBox(
                        //                   width: 15.w,
                        //                 ),
                        //                 Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.start,
                        //                   children: [
                        //                     Text(
                        //                       "${e.phoneContact.name.first} ${e.phoneContact.name.last ?? ''}",
                        //                       style: w300_12(),
                        //                     ),
                        //                     SizedBox(
                        //                       height: 4.h,
                        //                     ),
                        //                     Text(
                        //                       e.phoneContact.phones[0].number ??
                        //                           '',
                        //                       style: w300_10(
                        //                         color: AppColors.dark2GreyColor,
                        //                       ),
                        //                     )
                        //                   ],
                        //                 ),
                        //                 Expanded(
                        //                   child: SizedBox(
                        //                     width: 15.w,
                        //                   ),
                        //                 ),
                        //                 RadioSelectionWidget(
                        //                     selected: e.selected),
                        //               ]),
                        //             ),
                        //           ))
                        //       .toList(),
                        // ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppButton(
                    onPressedFunction: () async {

                      cloneUsers.removeWhere((element) => element.selected);



                      //new added contacts
                      clonePhoneContacts
                          .removeWhere((element) => element.selected);
                      inviteController.tempContactsList.forEach((element) {
                        element.selected = false;
                        clonePhoneContacts.forEach((cg) {
                          if (cg.phoneContact.id == element.phoneContact.id) {
                            element.selected = true;
                          }
                        });
                      });

                      //new added redeo contacts
                      cloneRedeoContacts
                          .removeWhere((element) => element.selected);
                      inviteController.tempRedeoList.forEach((element) {
                        element.selected = false;
                        cloneRedeoContacts.forEach((cg) {
                          if (cg.id == element.id) {
                            element.selected = true;
                          }
                        });
                      });

                      inviteController.refreshCount();
                      Get.back(result: cloneUsers);
                    },
                    child: Text(
                      'Remove',
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
}
