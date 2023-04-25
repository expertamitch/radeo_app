import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/screens/authentication/login_page.dart';
import 'package:redeo/screens/authentication/register_page.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../assets/images.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import '../../widgets/app_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              AppText(
                textSize: 16,
                text: "Welcome to REDEO",
                color: AppColors.purpleColor,
                fontWeight: FontWeight.w800,
              ),
              SizedBox(
                height: 20,
              ),
              ImageView(
                path: Images.welcomeScreenLogo,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.purpleColor),
                      onPressed: () {
                        Get.to(LoginPage());
                      },
                      child: Text(
                        'Login Now',
                        style: w600_14(color: Colors.white),
                      ))),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.lighBlueColor),
                      onPressed: () {
                        Get.to(RegisterPage());
                      },
                      child: Text(
                        'Register Now',
                        style: w600_14(color: Colors.white),
                      ))),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(height: 1, color: AppColors.greyColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Or login with',
                    style: w500_12(),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(height: 1, color: AppColors.greyColor),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/screen 1/google.svg',
                              height: 20, semanticsLabel: 'Acme Logo'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Google',
                            style: w500_12(),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/screen 1/Facebook.svg',
                              height: 20, semanticsLabel: 'Acme Logo'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Facebook',
                            style: w500_12(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
