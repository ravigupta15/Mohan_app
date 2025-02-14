// import 'package:patient/utils/constants.dart';
import 'package:mohan_impex/core/constant/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSharePreference {
  static late final SharedPreferences sharedPrefs;
  static final LocalSharePreference _instance = LocalSharePreference._internal();
  factory LocalSharePreference() => _instance;
  LocalSharePreference._internal();

  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }
  // static String get token => sharedPrefs.getString(AppConstants.TOKEN) ?? "";
  // static set setToken(String value) {
  //   sharedPrefs.setString(AppConstants.TOKEN, value);
  // }

  static bool get isFirstTime => sharedPrefs.getBool(AppConstants.IS_FIRST_TIME) ?? false;
  static set setIsFirstTime(bool value) {
    sharedPrefs.setBool(AppConstants.IS_FIRST_TIME, value);
  }

   static String get token =>
      sharedPrefs.getString(AppConstants.TOKEN) ?? "";
  static set setToken(String value) {
    sharedPrefs.setString(AppConstants.TOKEN, value);
  }

   static String get userRole =>
      sharedPrefs.getString(AppConstants.USER_ROLE) ?? "";
  static set setUserRole(String value) {
    sharedPrefs.setString(AppConstants.USER_ROLE, value);
  }

  static String get userName =>
      sharedPrefs.getString(AppConstants.USER_NAME) ?? "";
  static set setUserName(String value) {
    sharedPrefs.setString(AppConstants.USER_NAME, value);
  }

   static String get empId =>
      sharedPrefs.getString(AppConstants.EMP_ID) ?? "";
  static set setEmpId(String value) {
    sharedPrefs.setString(AppConstants.EMP_ID, value);
  }


static String get fcmToken =>
      sharedPrefs.getString(AppConstants.FCM_TOKEN) ?? "";
  static set setFcmToken(String value) {
    sharedPrefs.setString(AppConstants.FCM_TOKEN, value);
  }

  static String get password => sharedPrefs.getString(AppConstants.PASSWORD) ?? "";
  static set setPassword(String value) {
    sharedPrefs.setString(AppConstants.PASSWORD, value);
  }

  static String get currentLatitude =>
      sharedPrefs.getString(AppConstants.LAT) ?? "";
  static set setCurrentLatitude(String value) {
    sharedPrefs.setString(AppConstants.LAT, value);
  }

  static String get currentLongitude =>
      sharedPrefs.getString(AppConstants.LONG) ?? "";
  static set setCurrentLongitude(String value) {
    sharedPrefs.setString(AppConstants.LONG, value);
  }

}
