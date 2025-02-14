import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/core/services/internet_connectivity.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:mohan_impex/utils/message_helper.dart';
enum ApiMethod {get,post,put,delete}


class ApiService{
Future<Response?> makeRequest({
  required String apiUrl,
  required String method,  
  final data, 
  Map<String, dynamic>? queryParameters, 
  bool isErrorMessageShow=true,
}) async {
  Dio dio = Dio();
  Options options = Options(method: method,headers: checkHeader(apiUrl) ? headerWithAuth() : headerWithoutAuth());

  Response response;  
  try {
    bool isConnected = await InternetConnectivity.isConnected();
    if(!isConnected){
      MessageHelper.showInternetSnackBar();
      return null;
    }
    print(data);
     response = await dio.request(
      // cancelToken: cancelToken,
        apiUrl,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      log(json.encode(response.data));
    return _handleResponse(response, isErrorMessageShow);
  } on DioException catch (e) {
    print(e.response);
    _handleResponse(e.response!, isErrorMessageShow);
  }
  return null;
}


checkHeader(url){
switch (url) {
  case ApiUrls.generateOtpUrl:
    return false;
  case ApiUrls.loginUrl:
  return false;
  case ApiUrls.otpVerifyUrl:
  return false;
  case ApiUrls.updateResetPasswordUrl:
  return false;
  default:
  return true;
}
}

headerWithAuth(){
  return {
    'Authorization':"Bearer ${LocalSharePreference.token}"  
  };
}

headerWithoutAuth(){
  return null;
}
  _handleResponse(Response response, bool showErrorMessage) {
      if(response.statusCode == 200){
       return response; // Success
      }
      else if(response.statusCode == 401){
        LogoutHelper.logout();
      MessageHelper.showErrorSnackBar(navigatorKey.currentContext!,response.data['message'].toString());
      }        
      else{
      MessageHelper.showErrorSnackBar(navigatorKey.currentContext!,response.data['message'].toString());
      }
  }}