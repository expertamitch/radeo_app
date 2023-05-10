import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../assets/images.dart';
import '../../../styling/app_colors.dart';
import '../../../styling/font_style_globle.dart';
 
import '../../../widgets/image_view.dart';
import 'package:redeo/widgets/app_button.dart';

class EditEventDetailsPage extends StatefulWidget {
  const EditEventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EditEventDetailsPage> createState() => _EditEventDetailsPageState();
}

class _EditEventDetailsPageState extends State<EditEventDetailsPage> {
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
                AppButton(
                    onPressedFunction: () {},
                    child: Text(
                      'Submit',
                      style: w300_12(color: Colors.white),
                    ),
                    height: 30.h,
                    sodiumShapeBorder: true,
                    width: null,
                    buttonColor: AppColors.purpleColor)
              ],
            ),
            SizedBox(
              width: 10.w,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(4)),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      // PrettyQr(
                      //   // image: AssetImage('images/twitter.png'),
                      //   typeNumber: 3,
                      //   size: 140,
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
                        style: w600_20(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '27 Apr 2023, 3:17 PM',
                        style: w300_14(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        '2006 Chapmans Lane, San Francisco, California',
                        style: w300_14(
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                Center(
                  child: Text(
                    'Requested by John Doe',
                    style: w300_13(
                      color: AppColors.blueColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.purpleColor,
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    Text(
                      'RESERVE MY SPOT',
                      style: w300_13(color: Colors.white),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 10.w,
                    )),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightPurpleColor,
                          borderRadius: BorderRadius.circular(4)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'No',
                        style: w300_13(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.lightPurpleColor,
                          borderRadius: BorderRadius.circular(4)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'Yes',
                        style: w300_13(color: Colors.white),
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Client Name',
                              style: w300_13(
                                color: AppColors.blueColor,
                              ),
                            ),
                            TextFormField(
                              style: w300_14(),
                              decoration: InputDecoration(
                                  hintStyle: w300_14(
                                    color: AppColors.dark2GreyColor,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Enter Name'),
                            ),
                          ],
                        ),
                      ),
                      ImageView(
                        path: Images.smallUploadImg,
                        width: 60,
                      )
                    ],
                  ),
                ),
                Divider(thickness: 1, color: AppColors.greyColor),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Additional Guest',
                        style: w300_13(
                          color: AppColors.blueColor,
                        ),
                      ),
                      TextFormField(
                        style: w300_14(),
                        decoration: InputDecoration(
                            hintStyle: w300_14(
                              color: AppColors.dark2GreyColor,
                            ),
                            border: InputBorder.none,
                            hintText: '00'),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1, color: AppColors.greyColor),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Needs',
                        style: w300_13(
                          color: AppColors.blueColor,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        style: w300_14(),
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintStyle: w300_14(
                              color: AppColors.dark2GreyColor,
                            ),
                            hintText: 'Enter Needs Here…',
                            fillColor: AppColors.lightGreyColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: AppColors.lightGreyColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: AppColors.lightGreyColor)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: AppColors.lightGreyColor))),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter a name'
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ]));
  }
}
