import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:redeo/screens/authentication/controller/auth_controller.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/snackbar_util.dart';

class ForgotPasswordOtp extends StatefulWidget {
  const ForgotPasswordOtp({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOtp> createState() => _ForgotPasswordOtpState();
}

class _ForgotPasswordOtpState extends State<ForgotPasswordOtp> {
  String otp = '';
  String email = '';
  late Timer timer;
  AuthController controller = Get.find();
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
                Pinput(
                  length: 6,
                  onChanged: (data){
                    otp=data;
                  },
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  keyboardType: TextInputType.number,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                   defaultPinTheme: PinTheme(

                     width: 50,
                    height: 050,
                    textStyle: w300_14(),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0XFFCECECE).withOpacity(0.3),
                          offset: Offset(1, 4),
                          blurRadius: 3,
                          spreadRadius: 0.2,
                        )
                      ],
                      border: Border.all(color: const Color(0XFFCECECE)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  ],
                  onCompleted: (pin) async {
                    otp = pin;
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
                              email = Get.arguments;
                              bool success = await controller.forgotPassword(
                                  mobile: email);

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
                      email = Get.arguments;
                      if (otp.length == 6) {
                        // Get.toNamed(Routes.resetPasswordScreen,arguments: email);
                        Get.toNamed(Routes.resetPasswordScreen,
                            arguments: [email, otp]);
                      } else {
                        showErrorSnackBar('Please enter valid OTP');
                      }

                      // Navigator.pop(context);
                    },
                    child: Text(
                      'Next',
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
