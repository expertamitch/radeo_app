import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/authentication/fogot_password_page.dart';
import 'package:redeo/screens/authentication/otp_verification_page.dart';
import 'package:redeo/screens/authentication/register_page.dart';
import 'package:redeo/screens/authentication/welcome_page.dart';
import 'package:redeo/screens/notice_of_event/create_notice_of_event_page.dart';
import '../screens/authentication/login_page.dart';
import '../screens/contacts/contacts_page.dart';
import '../screens/create_message/create_message_page.dart';

import '../screens/create_message/review_message/review_message_page.dart';
import '../screens/create_message/select message/select_audio_message_page.dart';
import '../screens/create_message/select message/select_text_message_page.dart';

import '../screens/create_message/select message/select_video_message_page.dart';
import '../screens/do_not_call/do_not_call_page.dart';
import '../screens/event/create_new_event/cordinator/cordinator_page.dart';
import '../screens/event/create_new_event/create_event_page.dart';
import '../screens/event/event_details_page/edit_event_details_page.dart';
import '../screens/event/event_details_page/event_details_page.dart';
import '../screens/event/events_page.dart';
import '../screens/field_service/field_service_page.dart';
import '../screens/field_service/map_page.dart';
import '../screens/groups/create_group_page.dart';
import '../screens/groups/groups_page.dart';
import '../screens/message/chat_messages_page.dart';
import '../screens/message/message_page.dart';
import '../screens/notice_of_event/history_page.dart';
import '../screens/notice_of_event/notice_of_event_summary_page.dart';
import '../screens/notice_of_event/return_visits.dart';
import '../screens/scan_qr_page/scan_qr_page.dart';
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

    //contacts
    GetPage(
      name: Routes.contactScreen,
      transition: Transition.cupertino,
      page: () => ContactPage(),
    ),

    //create messages
    GetPage(
      name: Routes.createMessageScreen,
      transition: Transition.cupertino,
      page: () => CreateMessagePage(),
    ),
    GetPage(
      name: Routes.reviewMessageScreen,
      transition: Transition.cupertino,
      page: () => ReviewMessagePage(),
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

    //do not call
    GetPage(
      name: Routes.doNotCallScreen,
      transition: Transition.cupertino,
      page: () => DoNotCallPage(),
    ),

    //event
    GetPage(
      name: Routes.eventScreen,
      transition: Transition.cupertino,
      page: () => EventPage(),
    ),
    GetPage(
      name: Routes.createEventScreen,
      transition: Transition.cupertino,
      page: () => CreateEventPage(),
    ),
    GetPage(
      name: Routes.cordinatorScreen,
      transition: Transition.cupertino,
      page: () => CordinatorPage(),
    ),
    GetPage(
      name: Routes.eventDetailsScreen,
      transition: Transition.cupertino,
      page: () => EventDetailsPage(),
    ),
    GetPage(
      name: Routes.editEventDetailsScreen,
      transition: Transition.cupertino,
      page: () => EditEventDetailsPage(),
    ),

    //field service
    GetPage(
      name: Routes.fieldServiceScreen,
      transition: Transition.cupertino,
      page: () => FieldServicePage(),
    ),
    GetPage(
      name: Routes.filedServiceMapPageScreen,
      transition: Transition.cupertino,
      page: () => FiledServiceMapPage(),
    ),

    //groups
    GetPage(
      name: Routes.groupsPageScreen,
      transition: Transition.cupertino,
      page: () => GroupsPage(),
    ),
    GetPage(
      name: Routes.createGroupScreen,
      transition: Transition.cupertino,
      page: () => CreateGroupPage(),
    ),

    //message
    GetPage(
      name: Routes.messagePageScreen,
      transition: Transition.cupertino,
      page: () => MessagePage(),
    ),
    GetPage(
      name: Routes.chatMessageScreen,
      transition: Transition.cupertino,
      page: () => ChatMessagePage(),
    ),

    //notice of event
    GetPage(
      name: Routes.createNoticeOfEventScreen,
      transition: Transition.cupertino,
      page: () => CreateNoticeOfEvent(),
    ),
    GetPage(
      name: Routes.historyPage,
      transition: Transition.cupertino,
      page: () => HistoryPage(),
    ),
    GetPage(
      name: Routes.noticeOfEventSummaryScreen,
      transition: Transition.cupertino,
      page: () => NoticeOfEventSummaryPage(),
    ),
    GetPage(
      name: Routes.returnVisitsScreen,
      transition: Transition.cupertino,
      page: () => ReturnVisitsPage(),
    ),

    //scan qr page
    GetPage(
      name: Routes.scanQrScreen,
      transition: Transition.cupertino,
      page: () => ScanQrPage(),
    ),
  ];
}
