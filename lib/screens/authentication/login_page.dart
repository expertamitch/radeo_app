import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/widgets/colors.dart';

import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberPassword = false;
  String username = '';
  String password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.authPageBg), fit: BoxFit.cover)),
              child: Flexible(
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.0),
                      child: Text('Sign in to your Account',
                          style: w900_35(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    decoration: inputDecoration.copyWith(labelText: 'Username'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter username'
                        : null,
                    onChanged: (value) => setState(() {
                      username = value;
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    decoration: inputDecoration.copyWith(labelText: 'Password'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter password'
                        : null,
                    onChanged: (value) => setState(() {
                      password = value;
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Row(
                        children: [
                          Checkbox(
                            value: rememberPassword,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (!states.contains(MaterialState.selected)) {
                                return AppColors.dark2GreyColor;
                              }
                              return AppColors.blueColor;
                            }),
                            onChanged: (value) {
                              setState(() {
                                rememberPassword = value ?? false;
                              });
                            },
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  rememberPassword = !rememberPassword;
                                });
                              },
                              child:
                                  Text('Remember Password', style: w300_12())),
                        ],
                      )),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.forgotPasswordScreen);
                          },
                          child: Text('Forgot Password ?',
                              style: w300_12(
                                color: AppColors.blueColor,
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppButton(
                      onPressedFunction: () {
                        print('username : $username');
                        print('password : $password');
                        Get.toNamed(Routes.homepageScreen);
                      },
                      child: Text(
                        'Login Now',
                        style: w900_15(color: Colors.white),
                      ),
                      height: 50.h,
                      buttonColor: AppColors.purpleColor),
                  Expanded(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ', style: w300_12()),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.registerScreen);
                        },
                        child: Text('Register Now',
                            style: w900_12(
                              color: AppColors.purpleColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
