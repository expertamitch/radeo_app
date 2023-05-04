import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/authentication/fogot_password_page.dart';
import 'package:redeo/screens/authentication/otp_verification_page.dart';
import 'package:redeo/screens/authentication/register_page.dart';
import 'package:redeo/screens/authentication/welcome_page.dart';
import 'package:redeo/screens/notice_of_event/create_notice_of_event_page.dart';
import '../screens/authentication/login_page.dart';
import '../screens/create_message/create_message_page.dart';

import '../screens/create_message/select message/select_audio_message_page.dart';
import '../screens/create_message/select message/select_text_message_page.dart';

import '../screens/create_message/select message/select_video_message_page.dart';
import '../screens/notice_of_event/history_page.dart';
import '../screens/notice_of_event/notice_of_event_summary_page.dart';
import '../screens/splash/splash_binding.dart';
import '../screens/splash/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.splash,
        transition: Transition.cupertino,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    //authentication
    GetPage(
      name: Routes.mainScreen,
      transition: Transition.cupertino,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: Routes.loginScreen,
      transition: Transition.cupertino,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.registerScreen,
      transition: Transition.cupertino,
      page: () => RegisterPage(),
    ),
    GetPage(
      name: Routes.forgotPasswordScreen,
      transition: Transition.cupertino,
      page: () => ForgotPasswordPage(),
    ),
    GetPage(
      name: Routes.otpVerficationScreen,
      transition: Transition.cupertino,
      page: () => OtpVerficationPage(),
    ),
    //create messages
    GetPage(
      name: Routes.createMessageScreen,
      transition: Transition.cupertino,
      page: () => CreateMessagePage(),
    ),
    GetPage(
      name: Routes.selectTextMessageScreen,
      transition: Transition.cupertino,
      page: () => SelectTextMessagePage(),
    ),
    GetPage(
      name: Routes.selectAudioMessageScreen,
      transition: Transition.cupertino,
      page: () => SelectAudioMessage(),
    ),
    GetPage(
      name: Routes.selectVideoMessageScreen,
      transition: Transition.cupertino,
      page: () => SelectVideoMessagePage(),
    ),
    //notice of event
    GetPage(
      name: Routes.createNoticeOfEventScreen,
      transition: Transition.cupertino,
      page: () => CreateNoticeOfEvent(),
    ),
    GetPage(
      name: Routes.noticeOfEventSummaryScreen,
      transition: Transition.cupertino,
      page: () => NoticeOfEventSummaryPage(),
    ),
    GetPage(
      name: Routes.historyPage,
      transition: Transition.cupertino,
      page: () => HistoryPage(),
    ),
  ];
}
