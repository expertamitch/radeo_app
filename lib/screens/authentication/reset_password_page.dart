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

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String otp = '';
  String emailId = '';
  String password = '';
  String confirmPassword = '';
  var args=Get.arguments;

  // AuthController controller = Get.find();
  AuthController controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    emailId=args[0];
    otp=args[1];
    print('email--$emailId');
    print('otp--$otp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 190,
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
                  child: Text('Reset password',
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
                    obscuringCharacter: '✱',
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: w600_14(),
                    obscureText: true,
                    decoration: inputDecoration.copyWith(
                      labelText: 'New Password',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter new password'
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
                    textInputAction: TextInputAction.done,

                    obscureText: true,
                    obscuringCharacter: '✱',
                    decoration: inputDecoration.copyWith(
                        labelText: 'Confirm New Password'),
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
                          var success = await controller.resetPassword(
                              email: emailId, otp: otp, password: password);
                          if (success) Get.offAllNamed(Routes.loginScreen);
                        }
                      },
                      child: Text(
                        'Update',
                        style: w900_15(color: Colors.white),
                      ),
                      height: 50.h,
                      buttonColor: AppColors.purpleColor),
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
