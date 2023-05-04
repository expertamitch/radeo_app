import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/home_page.dart';
import 'package:redeo/widgets/colors.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';

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
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.0),
                      child: Text('Sign in to your Account',
                          style: w600_35(color: Colors.white)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w500_14(),
                    decoration: inputDecoration.copyWith(labelText: 'Username'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter username'
                        : null,
                    onChanged: (value) => setState(() {
                      username = value;
                    }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w500_14(),
                    decoration: inputDecoration.copyWith(labelText: 'Password'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter password'
                        : null,
                    onChanged: (value) => setState(() {
                      password = value;
                    }),
                  ),
                  SizedBox(
                    height: 10,
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
                                  Text('Remember Password', style: w500_12())),
                        ],
                      )),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.forgotPasswordScreen);
                          },
                          child: Text('Forgot Password ?',
                              style: w500_12(
                                color: AppColors.blueColor,
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
                            print('username : $username');
                            print('password : $password');
                            Get.to(DummyHomepage());
                          },
                          child: Text(
                            'Login Now',
                            style: w600_14(color: Colors.white),
                          ))),
                  Expanded(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ', style: w500_12()),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.registerScreen);
                        },
                        child: Text('Register Now',
                            style: w700_12(
                              color: AppColors.purpleColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
