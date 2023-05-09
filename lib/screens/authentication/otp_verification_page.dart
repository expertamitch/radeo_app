import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../home_page.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class OtpVerficationPage extends StatefulWidget {
  const OtpVerficationPage({Key? key}) : super(key: key);

  @override
  State<OtpVerficationPage> createState() => _OtpVerficationPageState();
}

class _OtpVerficationPageState extends State<OtpVerficationPage> {
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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: Text('OTP Verification',
                        style: w600_35(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  child: AppText(
                      text: 'Check your mobile to see the OTP',
                      color: Colors.white,
                      textSize: 14),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                OTPTextField(
                  length: 4,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: MediaQuery.of(context).size.width / 5.6,
                  style: w300_14(),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    AppText(text: 'Send code in ', textSize: 14),
                    sendOtpSecondsCountdown != 0
                        ? AppText(
                            text: '00:${sendOtpSecondsCountdown}',
                            textSize: 14,
                            fontWeight: FontWeight.bold,
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: AppText(
                                text: 'Get OTP',
                                textSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blueColor)),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: AppColors.purpleColor),
                        onPressed: () {
                          Get.toNamed(Routes.homepageScreen);
                        },
                        child: Text(
                          'Verfy OTP',
                          style: w600_14(color: Colors.white),
                        ))),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
