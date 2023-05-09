import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/colors.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: Text('Forgot your Password',
                        style: w600_35(color: Colors.white)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0),
                    child: AppText(
                        text: 'Please enter your register email address',
                        color: Colors.white,
                        textSize: 14),
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
                children: [
                  TextFormField(
                    style: w300_14(),
                    decoration: inputDecoration.copyWith(labelText: 'Email ID'),
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 40,
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
                            if (_formKey.currentState!.validate()) {
                              // print('username : $username');
                            }
                          },
                          child: Text(
                            'Submit Now',
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
                      Text('Don\'t have an account? ', style: w300_12()
                          //  TextStyle(color: Colors.black, fontSize: 14)
                          ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.registerScreen);
                        },
                        child: Text('Register Now',
                            style: w600_12(
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
