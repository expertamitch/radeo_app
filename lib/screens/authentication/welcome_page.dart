import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:redeo/widgets/image_view.dart';
import '../../assets/images.dart';
import '../../route/routes.dart';
import '../../styling/app_colors.dart';
import '../../styling/font_style_globle.dart';
import 'package:redeo/widgets/app_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            Text(
              "Welcome to REDEO",
              style: w800_16(
                color: AppColors.purpleColor,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            ImageView(
              path: Images.welcomeScreenLogo,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            Expanded(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            AppButton(
                onPressedFunction: () {
                  Get.toNamed(Routes.loginScreen);
                },
                child: Text(
                  'Login Now',
                  style: w600_14(color: Colors.white),
                ),
                height: 50.h,
                buttonColor: AppColors.purpleColor),
            SizedBox(
              height: 15.h,
            ),
            AppButton(
                onPressedFunction: () {
                  Get.toNamed(Routes.registerScreen);
                },
                child: Text(
                  'Register Now',
                  style: w600_14(color: Colors.white),
                ),
                height: 50.h,
                buttonColor: AppColors.blueColor),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(height: 1, color: AppColors.greyColor),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Or login with',
                  style: w300_12(),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Container(height: 1, color: AppColors.greyColor),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
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
                          width: 10.w,
                        ),
                        Text(
                          'Google',
                          style: w300_12(),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
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
                          width: 10.w,
                        ),
                        Text(
                          'Facebook',
                          style: w300_12(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 20.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
