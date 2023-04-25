import 'dart:convert';
import 'package:get_storage/get_storage.dart';
abstract class StorageUtils {
  static saveDownloadedImagePath(List data) {
    GetStorage().write('downloadedImages', json.encode(data));
  }

  static saveLanguage(String lang) {
    GetStorage().write('lang', lang);
  }

  static saveToken(String token) {
    GetStorage().write('token', token);
  }

  static saveUserId(String uid) {
    GetStorage().write('uid', uid);
  }

  static saveSubId(String uid) {
    GetStorage().write('sub', uid);
  }
  static saveTempToken(String uid) {
    GetStorage().write('tempToken', uid);
  }



  static saveAuth0UserId(String uid) {
    GetStorage().write('auth0uid', uid);
  }

  static saveEmail(String email) {
    GetStorage().write('email', email);
  }

  static Future  biometricEnabled(bool enabled) {
    return GetStorage().write('bioEnabled', enabled);
  }


  static saveMobile(String mobile) {
    GetStorage().write('mobile', mobile);
  }

  static saveFName(String name) {
    GetStorage().write('fname', name);
  }

  static saveLName(String name) {
    GetStorage().write('lname', name);
  }

  static saveProfileImage(String profileImage) {
    GetStorage().write('profileImage', profileImage);
  }

  static String? getToken() {
    return GetStorage().read('token');
  }

  static String? getUid() {
    return GetStorage().read('uid');
  }

  static String? getEmail() {
    return GetStorage().read('email');
  }

  static String? getAuth0UserId() {
    return GetStorage().read('auth0uid');
  }

  static String? getMobile() {
    return GetStorage().read('mobile');
  }

  static String? getFName() {
    return GetStorage().read('fname');
  }

  static String? getLName() {
    return GetStorage().read('lname');
  }


  static bool getBioEnabled() {
    return GetStorage().read('bioEnabled')??false;
  }

  static String getSub() {
    return GetStorage().read('sub') ?? "";

  }



  static getTempToken(   ) {
     return GetStorage().read('tempToken') ?? "";

  }


  static String? getLanguage() {
    return GetStorage().read('lang') ?? "english";
  }

  static String getProfileImage() {
    return GetStorage().read('profileImage') ?? "";
  }




  static List<dynamic> getDownloadedImagePath() {
    var data = GetStorage().read('downloadedImages');
    if (data != null)
      return json.decode(data);
    else
      return [];
  }

  static Future deleteAll() {
    return GetStorage().erase();
  }

 }
