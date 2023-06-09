import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  String email = '';
  AuthController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

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
                    child: Text('Please enter your register email address',
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
                  TextFormField(
                    style: w600_14(),
                    decoration: inputDecoration.copyWith(labelText: 'Email ID'),
                    controller: usernameController,
                    validator: (value) => Validators.validateEmail(value),
                    onChanged: (value) => setState(() {
                      email = value;
                    }),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  AppButton(
                      buttonColor: AppColors.purpleColor,
                      height: 50.h,
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await controller.forgotPassword(
                              email: usernameController.text);

                          if (success) Get.toNamed(Routes.forgotPasswordOtpScreen,arguments: email);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ', style: w300_12()
                          //  TextStyle(color: Colors.black, fontSize: 14)
                          ),
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
