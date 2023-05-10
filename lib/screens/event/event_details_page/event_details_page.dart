import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../assets/images.dart';
import '../../../route/routes.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';

import '../../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.darkGreyColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.editEventDetailsScreen);
                },
                child: ImageView(
                  path: Images.editIcon,
                  height: 17,
                )),
            SizedBox(
              width: 15.w,
            ),
            GestureDetector(
              onTap: () {
                //delete
              },
              child: ImageView(
                path: Images.deleteIcon,
                height: 17,
              ),
            ),
            SizedBox(
              width: 15.w,
            )
          ],
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
                        // PrettyQr(
                        //   // image: AssetImage('images/twitter.png'),
                        //   typeNumber: 3,
                        //   size: 150,
                        //   data: 'https://www.google.ru',
                        //   errorCorrectLevel: QrErrorCorrectLevel.M,
                        //   roundEdges: true, elementColor: Colors.white,
                        // ),
                        ImageView(
                          path: Images.barcodeImg,
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Event Name',
                          style: w900_18(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '27 Apr 2023, 3:17 PM',
                          style: w300_13(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '2006 Chapmans Lane, San Francisco, California',
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
                        Text(
                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero',
                            style: w300_12()),
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
                          onPressedFunction: () {
                            Get.toNamed(Routes.addInviteeScreen);
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
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkGreyColor,
                        borderRadius: BorderRadius.circular(8)),
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
                          style: w300_13(),
                          decoration: InputDecoration(
                              hintStyle: w300_13(
                                color: AppColors.dark2GreyColor,
                              ),
                              border: InputBorder.none,
                              hintText: 'Search Clients...',
                              isDense: true),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  clientLstTile(
                      status: 'Accepted',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,sed diam nonumy eirmod.',
                      title: 'John Doe Client'),
                  clientLstTile(
                      status: 'Rejected',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,sed diam nonumy eirmod.',
                      title: 'John Doe Client'),
                  clientLstTile(
                      status: 'Pending',
                      subtitle:
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,sed diam nonumy eirmod.',
                      title: 'John Doe Client'),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ),
        ]));
  }

  clientLstTile(
      {required String title,
      required String subtitle,
      required String status}) {
    return Container(
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
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: w300_14()),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  subtitle,
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
}
