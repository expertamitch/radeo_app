import 'package:get/get.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/screens/alerts/alerts_screen.dart';
import 'package:redeo/screens/authentication/fogot_password_page.dart';
import 'package:redeo/screens/authentication/forgot_password_otp_page.dart';
import 'package:redeo/screens/authentication/otp_verification_page.dart';
import 'package:redeo/screens/authentication/register_page.dart';
import 'package:redeo/screens/authentication/welcome_page.dart';
import 'package:redeo/screens/create_contact/existing_contacts/add_manual_contact.dart';
import 'package:redeo/screens/create_message/custom_message/create_custom_message.dart';
import 'package:redeo/screens/create_message/text_message/enter_text_message_page.dart';
import 'package:redeo/screens/event/event_details_page/invite_contacts/invite_contacts_page.dart';
import 'package:redeo/screens/groups/edit_group_page.dart';
import 'package:redeo/screens/home/home_page.dart';
import 'package:redeo/screens/notice_of_event/create_notice_of_event_page.dart';
import 'package:redeo/screens/read_unread/read_detail_screen.dart';
import 'package:redeo/screens/return_visits/return_detail_screen.dart';
import 'package:redeo/screens/territory/choose_territory.dart';
import 'package:redeo/screens/territory/territory_assign_contacts/contacts_page.dart';
import 'package:redeo/screens/territory/territory_details_screen.dart';
import 'package:redeo/utils/qr_scanner.dart';

import '../screens/authentication/login_page.dart';
import '../screens/authentication/reset_password_page.dart';
import '../screens/chat/chat_messages_page.dart';
import '../screens/chat/chat_page.dart';
import '../screens/create_message/record_voice_message_page.dart';
import '../screens/create_message/review_message/review_message_page.dart';
import '../screens/create_message/select message/select_audio_message_page.dart';
import '../screens/create_message/select message/select_text_message_page.dart';
import '../screens/create_message/select message/select_video_message_page.dart';
import '../screens/do_not_call/add_dnc_screen.dart';
import '../screens/do_not_call/addresses_list_screen.dart';
import '../screens/event/create_new_event/create_event_page.dart';
import '../screens/event/edit_event.dart';
import '../screens/event/event_details_page/add_invitee_page.dart';
import '../screens/event/event_details_page/edit_event_details_page.dart';
import '../screens/event/event_details_page/event_details_page.dart';
import '../screens/field_service/map_page.dart';
import '../screens/groups/attendants_page.dart';
import '../screens/groups/create_group_page.dart';
import '../screens/invite/invitee_page.dart';
import '../screens/return_visits/create_return_page.dart';
import '../screens/return_visits/incomplete_return_detail_screen.dart';
import '../screens/return_visits/incomplete_returns_screen.dart';
import '../screens/return_visits/return_history_screen.dart';
import '../screens/notice_of_event/notice_of_event_summary_page.dart';
import '../screens/report/edit_report_page.dart';
import '../screens/report/share_report_page.dart';
import '../screens/splash/splash_binding.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/territory/territory_history_list_screen.dart';

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
        binding: SplashBinding()),
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
      name: Routes.forgotPasswordOtpScreen,
      transition: Transition.cupertino,
      page: () => ForgotPasswordOtp(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      transition: Transition.cupertino,
      page: () => ResetPassword(),
    ),
    GetPage(
        name: Routes.otpVerficationScreen,
        transition: Transition.cupertino,
        page: () => OtpVerficationPage(),
        arguments: Get.arguments),

    //create messages

    GetPage(
        name: Routes.reviewMessageScreen,
        transition: Transition.cupertino,
        page: () => ReviewMessagePage(),
        arguments: Get.arguments),
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
    GetPage(
      name: Routes.enterTextMessageScreen,
      transition: Transition.cupertino,
      page: () => EnterTextMessagePage(),
    ),
    GetPage(
      name: Routes.recordVoiceMessageScreen,
      transition: Transition.cupertino,
      page: () => RecordVoiceMessagePage(),
    ),

    //do not call
    GetPage(
        name: Routes.listOfAddressScreen,
        transition: Transition.cupertino,
        page: () => AddressesListScreen(),
        arguments: Get.arguments),

    GetPage(
        name: Routes.addDncScreen,
        transition: Transition.cupertino,
        page: () => AddDncScreen(),
        arguments: Get.arguments),

    //event

    GetPage(
      name: Routes.createEventScreen,
      transition: Transition.cupertino,
      page: () => CreateEventPage(),
    ),
    GetPage(
        name: Routes.eventDetailsScreen,
        transition: Transition.cupertino,
        page: () => EventDetailsPage(),
        arguments: Get.arguments),
    GetPage(
      name: Routes.inviteeScreen,
      transition: Transition.cupertino,
      page: () => InviteePage(),
    ),
    GetPage(
        name: Routes.addInviteeScreen,
        transition: Transition.cupertino,
        page: () => AddInviteePage(),
        arguments: Get.arguments),
    GetPage(
        name: Routes.editEventDetailsScreen,
        transition: Transition.cupertino,
        page: () => EditEventDetailsPage(),
        arguments: Get.arguments),

    GetPage(
        name: Routes.filedServiceMapPageScreen,
        transition: Transition.cupertino,
        page: () => FiledServiceMapPage(),
        arguments: Get.arguments),

    //groups

    GetPage(
      name: Routes.createGroupScreen,
      transition: Transition.cupertino,
      page: () => CreateGroupPage(),
    ),
    GetPage(
        name: Routes.attendantsScreen,
        transition: Transition.cupertino,
        page: () => AttendantsPage(),
        arguments: Get.arguments),

    //message
    GetPage(
        name: Routes.chatScreen,
        transition: Transition.cupertino,
        page: () => ChatPage(),
        arguments: Get.arguments),
    GetPage(
        name: Routes.chatMessageScreen,
        transition: Transition.cupertino,
        page: () => ChatMessagePage(),
        arguments: Get.arguments),

    //notice of event
    GetPage(
        name: Routes.createNoticeOfEventScreen,
        transition: Transition.cupertino,
        page: () => CreateNoticeOfEvent(),
        arguments: Get.arguments),
    GetPage(
        name: Routes.createReturnPageScreen,
        transition: Transition.cupertino,
        page: () => CreateReturnPage(),
        arguments: Get.arguments),
    GetPage(
        name: Routes.historyPage,
        transition: Transition.cupertino,
        page: () => ReturnHistoryPage(),
        arguments: Get.arguments),
    GetPage(
      name: Routes.noticeOfEventSummaryScreen,
      transition: Transition.cupertino,
      page: () => NoticeOfEventSummaryPage(),
    ),

    //Reports page

    GetPage(
        name: Routes.editReportsScreen,
        transition: Transition.cupertino,
        page: () => EditReportsPage(),
        arguments: Get.arguments),
    GetPage(
      name: Routes.shareReportsScreen,
      transition: Transition.cupertino,
      page: () => ShareReportsPage(),
    ),

    //homepage
    GetPage(
      name: Routes.homepageScreen,
      transition: Transition.cupertino,
      page: () => Homepage(),
    ),

    //homepage
    GetPage(
        name: Routes.editEventScreen,
        transition: Transition.cupertino,
        page: () => EditEvent(),
        arguments: Get.arguments),

    GetPage(
      name: Routes.territoryHistoryListScreen,
      transition: Transition.cupertino,
      page: () => TerritoryHistoryListScreen(),
    ),

    GetPage(
      name: Routes.contactPage,
      transition: Transition.cupertino,
      page: () => ContactsPage(),
    ),

    GetPage(
        name: Routes.territoryDetailsScreen,
        transition: Transition.cupertino,
        page: () => TerritoryDetailsScreen(),
        arguments: Get.arguments),

    GetPage(
      name: Routes.chooseTerritory,
      transition: Transition.cupertino,
      page: () => ChooseTerritory(),
    ),

    GetPage(
        name: Routes.createCustomMessage,
        transition: Transition.cupertino,
        page: () => CreateCustomMessage(),
        arguments: Get.arguments),

    GetPage(
        name: Routes.qrScanner,
        transition: Transition.cupertino,
        page: () => QRScanner(),
        arguments: Get.arguments),
    GetPage(
        name: Routes.editGroupScreen,
        transition: Transition.cupertino,
        page: () => EditGroupPage(),
        arguments: Get.arguments),

    GetPage(
        name: Routes.returnDetailScreen,
        transition: Transition.cupertino,
        page: () => ReturnDetailScreen(),
        arguments: Get.arguments),
    GetPage(
        name: Routes.incompleteReturnDetailScreen,
        transition: Transition.cupertino,
        page: () => IncompleteReturnDetailScreen(),
        arguments: Get.arguments),
    GetPage(
        name: Routes.incompleteReturnsScreen,
        transition: Transition.cupertino,
        page: () => IncompleteReturnsScreen(),
        arguments: Get.arguments),

    GetPage(
        name: Routes.inviteContactsScreen,
        transition: Transition.cupertino,
        page: () => InviteContactsPage(),
        arguments: Get.arguments),

    GetPage(
        name: Routes.addEditContactManually,
        transition: Transition.cupertino,
        page: () => AddManualContact(),
        arguments: Get.arguments),

    GetPage(
        name: Routes.readDetailScreen,
        transition: Transition.cupertino,
        page: () => ReadDetailScreen(),
        arguments: Get.arguments),
  ];
}
