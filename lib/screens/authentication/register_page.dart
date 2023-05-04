import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/colors.dart';
import 'login_page.dart';
import 'otp_verification_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(Images.authPageBg),
                        fit: BoxFit.cover)),
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
                      child: Text('Register your Account',
                          style: w600_40(color: Colors.white)),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontFamily: 'satoshi',
                    ),
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
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontFamily: 'satoshi',
                    ),
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
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: false,
                      spaceBetweenSelectorAndTextField: 0,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      formatInput: true,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputDecoration: inputDecoration.copyWith(
                          labelText: 'Mobile',
                          suffix: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'GET OTP',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.purpleColor),
                            ),
                          )),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),

                  // TextFormField(
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   style: TextStyle(
                  //     fontFamily: 'satoshi',
                  //   ),
                  //   decoration: inputDecoration.copyWith(
                  //       labelText: 'Mobile',
                  //       suffix: GestureDetector(
                  //         onTap: () {},
                  //         child: Text(
                  //           'GET OTP',
                  //           style: TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold,
                  //               color: AppColors.purpleColor),
                  //         ),
                  //       )),
                  //   validator: (value) => value == null || value.isEmpty
                  //       ? 'Please enter mobile no.'
                  //       : null,
                  //   onChanged: (value) => setState(() {
                  //     mobileNo = value;
                  //   }),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontFamily: 'satoshi',
                    ),
                    decoration: inputDecoration.copyWith(labelText: 'Email ID'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter email id'
                        : null,
                    onChanged: (value) => setState(() {
                      emailId = value;
                    }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontFamily: 'satoshi',
                    ),
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
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontFamily: 'satoshi',
                    ),
                    obscureText: true,
                    decoration:
                        inputDecoration.copyWith(labelText: 'Confirm Password'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please re enter password'
                        : null,
                    onChanged: (value) => setState(() {
                      confirmPassword = value;
                    }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.purpleColor),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Get.to(OtpVerficationPage());
                            }
                          },
                          child: Text(
                            'Register Now',
                            style: w600_14(color: Colors.white),
                          ))),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: w500_12()),
                      GestureDetector(
                        onTap: () {
                          Get.to(LoginPage());
                        },
                        child: Text('Login here',
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
            )
          ]),
        ),
      ),
    );
  }
}
