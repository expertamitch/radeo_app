import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:redeo/screens/authentication/controller/auth_controller.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../utils/snackbar_util.dart';

class OtpVerficationPage extends StatefulWidget {
  const OtpVerficationPage({Key? key}) : super(key: key);

  @override
  State<OtpVerficationPage> createState() => _OtpVerficationPageState();
}

class _OtpVerficationPageState extends State<OtpVerficationPage> {
  String otp = '';
  String mobileNo = '';
  AuthController controller = Get.find();
  late Timer timer;
  int sendOtpSecondsCountdown = 60;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (sendOtpSecondsCountdown == 0) {
        timer.cancel();
      } else {
        sendOtpSecondsCountdown--;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.authPageBg), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: Text('OTP Verification',
                        style: w900_35(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  child: Text(
                    'Check your mobile to see the OTP',
                    style: w300_14(
                      color: Colors.white,
                    ),
                    // color: Colors.white,
                    // textSize: 14
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            )),
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                OTPTextField(
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: MediaQuery.of(context).size.width / 7,
                  style: w300_14(),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    otp = pin;
                    print("Completed: " + pin);
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Text('Send code in ', style: w300_14()),
                    sendOtpSecondsCountdown != 0
                        ? Text('00:${sendOtpSecondsCountdown}',
                            style: w900_14())
                        : GestureDetector(
                            onTap: () async {
                              mobileNo = Get.arguments;
                              var success = await controller.resendOTP(
                                  mobileNo: mobileNo);
                              if (success) {
                                sendOtpSecondsCountdown = 60;
                                timer = Timer.periodic(Duration(seconds: 1),
                                    (timer) {
                                  if (sendOtpSecondsCountdown == 0) {
                                    timer.cancel();
                                  } else {
                                    sendOtpSecondsCountdown--;
                                  }
                                  setState(() {});
                                });
                              }
                            },
                            child: Text('Get OTP',
                                style: w900_14(color: AppColors.blueColor))),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                AppButton(
                    onPressedFunction: () async {
                      mobileNo = Get.arguments;
                      if (otp.length == 6) {
                        var success = await controller.verifyMobile(
                            mobileNo: mobileNo, otp: otp);
                        if (success) {
                          Get.offAllNamed(Routes.homepageScreen);
                        }
                      } else {
                        showErrorSnackBar('Please enter valid OTP');
                      }

                      // Navigator.pop(context);
                    },
                    child: Text(
                      'Verfy OTP',
                      style: w900_15(color: Colors.white),
                    ),
                    height: 50.h,
                    buttonColor: AppColors.purpleColor),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
