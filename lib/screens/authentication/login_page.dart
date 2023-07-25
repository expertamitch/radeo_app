import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:redeo/assets/images.dart';
import 'package:redeo/screens/authentication/controller/auth_controller.dart';
import 'package:redeo/utils/validators.dart';
import 'package:redeo/widgets/app_button.dart';
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
  String password = '';
  String mobileNo = '';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  String initialCountry = 'IN';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthController authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 172.h,
        flexibleSpace: Container(
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
                  leading: Container(),
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
            )),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        mobileNo = number.phoneNumber.toString();
                        // .replaceAll(number.dialCode.toString(), "");
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      validator: (value) {
                        return Validators.validateMobile(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      keyboardAction: TextInputAction.next,
                      spaceBetweenSelectorAndTextField: 0,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      maxLength: 10,
                      formatInput: false,
                      textStyle: w600_14(),
                      keyboardType:
                      TextInputType.numberWithOptions(signed: false, decimal: false),
                      inputDecoration: inputDecoration.copyWith(
                        labelText: 'Mobile',
                      ),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    obscuringCharacter: '✱',
                    obscureText: true,textInputAction: TextInputAction.done,
                    controller: passwordController,
                    validator: (value) => Validators.validatePassword(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    decoration: inputDecoration.copyWith(labelText: 'Password'),
                    onChanged: (value) => setState(() {
                      password = value;
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                       onPressed: () {
                         Get.toNamed(Routes.forgotPasswordScreen);
                       },
                       child: Text('Forgot Password ?',
                           style: w300_12(
                             color: AppColors.blueColor,
                           ))),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppButton(
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await authController.login(
                              mobile: mobileNo,
                              password: passwordController.text);

                          if (success) Get.offAllNamed(Routes.homepageScreen);
                        }
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
                          Get.offNamed(Routes.registerScreen);
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
