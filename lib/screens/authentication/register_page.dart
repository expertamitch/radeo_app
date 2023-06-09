import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:redeo/screens/authentication/controller/auth_controller.dart';
import 'package:redeo/utils/validators.dart';
import 'package:redeo/widgets/app_button.dart';

import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String mobileNo = '';
  String emailId = '';
  String password = '';
  String confirmPassword = '';

  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  // AuthController controller = Get.find();
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 212,
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
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.0),
                  child: Text('Register your Account',
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
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    decoration:
                        inputDecoration.copyWith(labelText: 'First Name'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter first name'
                        : null,
                    onChanged: (value) => setState(() {
                      firstName = value;
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    decoration:
                        inputDecoration.copyWith(labelText: 'Last Name'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter last name'
                        : null,
                    onChanged: (value) => setState(() {
                      lastName = value;
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        mobileNo=number.phoneNumber.toString();
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },validator: (value){
                        return Validators.validateMobile(value);
                    },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      spaceBetweenSelectorAndTextField: 0,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      formatInput: true,
                      textStyle: w600_14(),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration.copyWith(labelText: 'Email ID'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter email id'
                        : null,
                    onChanged: (value) => setState(() {
                      emailId = value;
                    }),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    obscuringCharacter: '✱',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    obscureText: true,
                    decoration: inputDecoration.copyWith(
                      labelText: 'Password',
                    ),
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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    obscureText: true,
                    obscuringCharacter: '✱',
                    decoration:
                        inputDecoration.copyWith(labelText: 'Confirm Password'),
                    validator: (value) => Validators.validateConfirmPassword(password,value),
                    onChanged: (value) => setState(() {
                      confirmPassword = value;
                    }),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  AppButton(
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          var success=await controller.register(
                              firstName: firstName,
                              lastName: lastName,
                              mobile: mobileNo,
                              email: emailId,
                              password: password);
                          if(success)
                            Get.toNamed(Routes.otpVerficationScreen, arguments: mobileNo);

                        }
                      },
                      child: Text(
                        'Register Now',
                        style: w900_15(color: Colors.white),
                      ),
                      height: 50.h,
                      buttonColor: AppColors.purpleColor),
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: w300_12()),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.loginScreen);
                        },
                        child: Text('Sign In Now',
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
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
          ]),
        ),
      ),
    );
  }
}
