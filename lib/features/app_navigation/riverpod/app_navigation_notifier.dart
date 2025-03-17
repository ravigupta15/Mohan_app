// Define a StateNotifier to manage the state

import 'package:flutter/material.dart';
import 'package:mohan_impex/api_config/api_service.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/app_navigation/riverpod/app_navigation_state.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';
import 'package:mohan_impex/utils/logout_helper.dart';
import 'package:riverpod/riverpod.dart';


class AppNavigationNotifier extends StateNotifier<AppNavigationState> {
  AppNavigationNotifier() : super(AppNavigationState(isLoading: false));
 
logoutApiFunction(BuildContext context)async{
  ShowLoader.loader(context);
  var body = {
    'access_token': LocalSharePreference.token
  };
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.logoutUrl, method: ApiMethod.post.name, data: body);
  ShowLoader.hideLoader();
  if(response!=null){
    LogoutHelper.logout();
  }
}

}
