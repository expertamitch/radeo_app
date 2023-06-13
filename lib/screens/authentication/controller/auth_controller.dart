import 'package:get/get.dart';
import 'package:redeo/network/storage_utils.dart';
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
      data['firstName'] = firstName;
      data['lastName'] = lastName;
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

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {};

      data['email'] = email;
      data['password'] = password;

      showLoader();
      final result = await BackendRepo().login(data: data);
      StorageUtils.saveToken(result.token??'');
      StorageUtils.saveUserId(result.info?.id.toString()??'');
      StorageUtils.saveFName(result.info?.firstName??'');
      StorageUtils.saveLName(result.info?.lastName??'');
      StorageUtils.saveEmail(result.info?.email??'');
      StorageUtils.saveMobile(result.info?.mobile??'');

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
}
