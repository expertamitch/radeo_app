abstract class Routes {
  static const splash = '/';

  //authentication
  static const mainScreen = '/mainScreen';
  static const loginScreen = '/loginScreen';
  static const registerScreen = '/registerScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const forgotPasswordOtpScreen = '/forgotPasswordOtpScreen';
  static const resetPasswordScreen = '/resetPasswordScreen';
  static const otpVerficationScreen = '/otpVerficationScreen';

  //create messages
   static const reviewMessageScreen = '/reviewMessageScreen';
  static const selectTextMessageScreen = '/selectTextMessageScreen';
  static const selectAudioMessageScreen = '/selectAudioMessageScreen';
  static const selectVideoMessageScreen = '/selectVideoMessageScreen';
  static const enterTextMessageScreen = '/enterTextMessageScreen';
  static const recordVoiceMessageScreen = '/recordVoiceMessageScreen';
  static const createCustomMessage = '/createCustomMessage';

  //do not call
  static const listOfAddressScreen = '/doNotCallScreen';
  static const addDncScreen = '/addDncScreen';

  //event page
   static const createEventScreen = '/createEventScreen';
  static const eventDetailsScreen = '/eventDetailsScreen';
  static const editEventDetailsScreen = '/editEventDetailsScreen';
  //invitee
  static const inviteeScreen = '/inviteeScreen';
  static const addInviteeScreen = '/addInviteeScreen';

  //field service
   static const filedServiceMapPageScreen = '/FiledServiceMapScreen';

  //groups page
   static const createGroupScreen = '/createGroupScreen';
   static const editGroupScreen = '/editGroupScreen';
  static const attendantsScreen = '/attendantsScreen';

  //message page
  static const chatScreen = '/chatScreen';
  static const chatMessageScreen = '/chatMessageScreen';

  //notice of event
  static const createNoticeOfEventScreen = '/createNoticeOfEventScreen';
  static const createReturnPageScreen = '/createReturnPageScreen';
  static const returnDetailScreen = '/returnDetailScreen';
  static const incompleteReturnsScreen = '/incompleteReturnsScreen';
  static const incompleteReturnDetailScreen = '/incompleteReturnDetailScreen';
  static const historyPage = '/historyPage';
  static const noticeOfEventSummaryScreen = '/noticeOfEventSummaryScreen';
   static const scanQrScreen = '/scanQrScreen';
   static const inviteContactsScreen = '/inviteContactsScreen';

  //reports page
   static const editReportsScreen = '/editReportsScreen';
  static const shareReportsScreen = '/shareReportsScreen';

  //homepage
  static const homepageScreen = '/homepageScreen';
  static const qrScanner = '/qrScanner';

//  territory
  static const territoryHistoryListScreen= '/territoryHistoryListScreen';
  static const territoryDetailsScreen= '/territoryDetailsScreen';
  static const chooseTerritory= '/chooseTerritory';



  static const contactPage= '/contactPage';
}
