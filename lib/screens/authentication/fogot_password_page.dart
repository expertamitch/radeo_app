import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:redeo/widgets/app_button.dart';
import 'package:redeo/widgets/colors.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../utils/validators.dart';
import 'controller/auth_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  AuthController controller = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController(), permanent: true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String mobileNo = '';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  String initialCountry = 'IN';

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
                    child: Text('Forgot your Password',
                        style: w900_35(color: Colors.white)),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: Text('Please enter your register mobile number',
                        style: w300_14(color: Colors.white)),
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
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                      inputDecoration: inputDecoration.copyWith(
                        labelText: 'Mobile',
                      ),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  AppButton(
                      buttonColor: AppColors.purpleColor,
                      height: 50.h,
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success =
                              await controller.forgotPassword(mobile: mobileNo);

                          if (success)
                            Get.toNamed(Routes.forgotPasswordOtpScreen,
                                arguments: mobileNo);
                        }
                      },
                      child: Text(
                        'Submit Now',
                        style: w900_15(color: Colors.white),
                      )),
                  Expanded(
                    child: SizedBox(
                      height: 20.h,
                    ),
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
