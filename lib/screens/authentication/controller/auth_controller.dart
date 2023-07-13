import 'package:get/get.dart';
import 'package:redeo/network/storage_utils.dart';
import 'package:redeo/route/routes.dart';
import 'package:redeo/utils/snackbar_util.dart';
import 'package:redeo/widgets/loader.dart';

import '../../../network/internet_exception.dart';
import '../../../network/repository/backend_repo.dart';

class AuthController extends GetxController {
  Future<bool> register({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data['first_name'] = firstName;
      data['last_name'] = lastName;
      data['mobile'] = mobile;
      data['email'] = email;
      data['password'] = password;

      showLoader();
      final result = await BackendRepo().createAccount(data: data);

      hideLoader();

      return true;
    } on InternetException {
      hideLoader();
      return false;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> verifyMobile({
    required String mobileNo,
    required String otp,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data['mobile'] = mobileNo;
      data['otp'] = otp;

      showLoader();
      final result = await BackendRepo().verifyMobileNumber(data: data);
      StorageUtils.saveToken(result.token ?? '');
      StorageUtils.saveUserId(result.info?.id.toString() ?? '');
      StorageUtils.saveFName(result.info?.firstName ?? '');
      StorageUtils.saveLName(result.info?.lastName ?? '');
      StorageUtils.saveEmail(result.info?.email ?? '');
      StorageUtils.saveMobile(result.info?.mobile ?? '');
      hideLoader();
      if (result.token == null || result.token!.isEmpty) {
        showErrorSnackBar('Invalid OTP');
        return false;
      }

      return true;
    } on InternetException {
      hideLoader();
      return false;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> resendOTP({
    required String mobileNo,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data['mobile'] = mobileNo;

      showLoader();
      final result = await BackendRepo().resendOTP(data: data);
      hideLoader();
      if (result.message != null && result.message!.isNotEmpty) {
        showSuccessSnackBar(result.message ?? '');
      }

      return true;
    } on InternetException {
      hideLoader();
      return false;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> forgotPassword({
    required String email,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data['email'] = email;

      showLoader();
      final result = await BackendRepo().forgotPassword(data: data);
      hideLoader();
      if (result.message != null && result.message!.isNotEmpty) {
        showSuccessSnackBar(result.message ?? '');
      }

      return true;
    } on InternetException {
      hideLoader();
      return false;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {};
      data['email'] = email;
      data['otp'] = otp;
      data['password'] = password;

      showLoader();
      final result = await BackendRepo().resetPassword(data: data);
      hideLoader();
      if (result.message != null && result.message!.isNotEmpty) {
        showSuccessSnackBar(result.message ?? '');
      }
      return true;
    } on InternetException {
      hideLoader();
      return false;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      return false;
    }
  }

  Future<bool> login({
    required String mobile,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {};

      data['mobile'] = mobile;
      data['password'] = password;

      showLoader();
      final result = await BackendRepo().login(data: data);
      hideLoader();
      if (result.info != null) {
        StorageUtils.saveToken(result.token ?? '');
        StorageUtils.saveUserId(result.info?.id.toString() ?? '');
        StorageUtils.saveFName(result.info?.firstName ?? '');
        StorageUtils.saveLName(result.info?.lastName ?? '');
        StorageUtils.saveEmail(result.info?.email ?? '');
        StorageUtils.saveMobile(result.info?.mobile ?? '');
        return true;
      } else {
        hideLoader();
        showErrorSnackBar(result.message!);



        return false;
      }
    } on InternetException {
      hideLoader();
      return false;
    } catch (e) {
      hideLoader();
      showErrorSnackBar(e.toString());

      if(e.toString()=="User not verified!") {
        var success=await resendOTP(mobileNo: mobile);

        if( success)
          Get.toNamed(Routes.otpVerficationScreen,arguments: mobile);
      }


      return false;
    }
  }
}
