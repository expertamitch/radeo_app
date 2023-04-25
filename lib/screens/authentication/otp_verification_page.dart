import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:redeo/screens/authentication/register_page.dart';

import '../../widgets/colors.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            decoration: BoxDecoration(color: lighBlueColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: lighBlueColor,
                  elevation: 0,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  child: Text(
                    'Check your mobile to see the OTP',
                    style: TextStyle(color: Colors.white),
                  ),
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
                  style: TextStyle(fontSize: 17),
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
                    Text('Send code in '),
                    sendOtpSecondsCountdown != 0
                        ? Text(
                            '00:${sendOtpSecondsCountdown}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Get OTP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lighBlueColor),
                            )),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: purpleColor),
                        onPressed: () {
                          // Get.to(LoginPage());
                        },
                        child: Text('Verfy OTP'))),
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
