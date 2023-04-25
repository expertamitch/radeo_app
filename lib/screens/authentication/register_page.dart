import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/authentication/login_page.dart';

import '../../widgets/colors.dart';
import 'otp_verification_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
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
                        'Register your\nAccount',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'First Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Last Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: inputDecoration.copyWith(
                      labelText: 'Mobile',
                      suffix: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'GET OTP',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: purpleColor),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: inputDecoration.copyWith(labelText: 'Email ID'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: inputDecoration.copyWith(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: inputDecoration.copyWith(labelText: 'Password'),
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
                          //register code here
                          //navigating to otp verification
                          Get.to(OtpVerficationPage());
                        },
                        child: Text('Register Now'))),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ));
                      },
                      child: Text('Login here',
                          style: TextStyle(
                              color: purpleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
