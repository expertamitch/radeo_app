import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:redeo/models/all_group_list_response_model.dart';
import 'package:redeo/network/storage_utils.dart';
import 'package:redeo/screens/event/event_controller.dart';
import 'package:redeo/widgets/app_button.dart';
import 'package:redeo/widgets/search_widget.dart';

import '../../../assets/images.dart';
import '../../../models/events_model.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
import '../../../utils/common_dialogs.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/loader.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  List<UserData> userList = [];
  RxList<UserData> tempUserList = RxList();

  EventController controller = Get.find();
  late EventInfoModel model;

  @override
  void initState() {
    model = Get.arguments;
    userList = model.eventUsers!;
    tempUserList.value = model.eventUsers!;
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
          actions:model.userId.toString()==    StorageUtils.getUid()? [

            GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.editEventScreen, arguments: model)
                      ?.then((value) {
                    if (value != null && value is EventInfoModel) {
                      this.model = value;
                      setState(() {
                        userList = model.eventUsers!;
                        tempUserList.value = model.eventUsers!;
                      });
                    }
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ImageView(
                    path: Images.editIcon,
                    height: 17,
                  ),
                )),
            SizedBox(
              width: 15.w,
            ),
            GestureDetector(
              onTap: () {
                showConfirmationDialog(context, "Do you want to delete event?",
                    yesCallback: () async {
                  bool success =
                      await controller.deleteEvent(model.id.toString());
                  if (success) {
                    showLoader();
                    await controller.getEventsList();
                    hideLoader();
                    Get.back();
                    Get.back();
                  }
                });
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ImageView(
                  path: Images.deleteIcon,
                  height: 17,
                ),
              ),
            ),
            SizedBox(
              width: 15.w,
            )
          ]:[],
        ),
        body: Stack(children: [
          Container(
            width: double.maxFinite,
            color: AppColors.darkGreyColor,
            height: 40,
            padding: EdgeInsets.only(left: 18, right: 16, bottom: 20),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: AppColors.blueColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        ImageView(
                          path: Images.barcodeImg,
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          model.name!,
                          style: w900_18(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          DateFormat('dd MMM yyyy, h:mm a')
                              .format(model.dateTime ?? DateTime.now()),
                          style: w300_13(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          model.location!,
                          style: w300_13(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: AppColors.darkGreyColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: w300_13(
                            color: AppColors.blueColor,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(model.description!, style: w300_12()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Client List',
                        style: w900_16(
                          color: Colors.black,
                        ),
                      ),
                      AppButton(
                          onPressedFunction: () async {
                            Get.toNamed(Routes.addInviteeScreen,
                                    arguments: model)
                                ?.then((detailModel) {
                              if (detailModel != null) {
                                model = detailModel;
                                userList = model.eventUsers!;
                                tempUserList.value = model.eventUsers!;
                                setState(() {});
                              }
                            });
                          },
                          child: Text(
                            'Add Invitee',
                            style: w300_12(color: Colors.white),
                          ),
                          sodiumShapeBorder: true,
                          width: null,
                          height: 30.h,
                          buttonColor: AppColors.purpleColor)
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SearchWidget(
                      hint: 'Search Clients...', onChange: executeSearch),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(() => Column(
                        mainAxisSize: MainAxisSize.max,
                        children: tempUserList
                            .map((e) =>
                                clientLstTile(data: e, status: 'Pending'))
                            .toList(),
                      )),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ]));
  }

  Widget clientLstTile({required UserData data, required String status}) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.greyColor))),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CircleAvatar(),
          SvgPicture.asset(
            Images.clientUserIcon,
            height: 45,
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.name ?? '', style: w300_14()),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  data.mobile ?? '',
                  style: w300_12(color: AppColors.dark2GreyColor),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: w300_12(
                color: status == 'Accepted'
                    ? AppColors.greenColor
                    : status == 'Rejected'
                        ? AppColors.redColor
                        : Colors.black),
          ),
        ],
      ),
    );
  }

  executeSearch(String searchedText) {
    tempUserList.value = userList.map((e) => UserData.clone(e)).toList();

    tempUserList.value.removeWhere((element) =>
        !element.name!.toLowerCase().contains(searchedText.toLowerCase()));
    tempUserList.refresh();
  }
}
