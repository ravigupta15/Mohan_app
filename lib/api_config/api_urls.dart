class ApiUrls {
  static const baseUrl = "http://4.186.63.57/api/method/";

  /// auth
  static const generateOtpUrl = "${baseUrl}mohan_impex.api.auth.generate_otp";
  static const loginUrl = "${baseUrl}mohan_impex.api.auth.login";
  static const otpVerifyUrl = "${baseUrl}mohan_impex.api.auth.validate_otp";
  static const updateResetPasswordUrl = "${baseUrl}mohan_impex.api.auth.reset_password";
 
 /// logout
 static const logoutUrl = "${baseUrl}mohan_impex.api.auth.logout";

 /// dashboard
 static const dashboardUrl = "${baseUrl}mohan_impex.api.dashboard";
 static const checkInUrl = "${baseUrl}mohan_impex.api.checkin";


 /// custom visit
 static const customVisitListUrl = "${baseUrl}mohan_impex.api.cvm.cvm_list";
}