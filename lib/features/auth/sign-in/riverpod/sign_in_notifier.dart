// Define a StateNotifier to manage the state
import 'package:flutter/material.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/app_navigation/pages/app_navigation_screen.dart';
import 'package:mohan_impex/features/auth/sign-in/model/sign_in_response_model.dart';
import 'package:mohan_impex/features/auth/sign-in/riverpod/sign_in_state.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../api_config/api_service.dart';

class SignInNotifier extends StateNotifier<SignInState> {

  SignInNotifier() : super(SignInState( userName: '',password: '',isLoading: false,isVisible: true,isCheckBox: false)){
     _emailController.addListener(() {
      state = state.copyWith(userName: _emailController.text);
    });
  }
 final TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get passwordController => _passwordController;

final formKey = GlobalKey<FormState>();


 @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

initFunction(){
  print('ssdfgh');
  // if(SessionManager.rememberMe){
  //   userNameController.text = SessionManager.username;
  //   passwordController.text = SessionManager.password;
  //   state = state.copyWith(isCheckBox: true);
  // }
}

void changeVisible(bool value){
  state = state.copyWith(isVisible: value);
}



//   void setName(String newName) {
//     state = state.copyWith(userName: newName);
//   }

updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}

resetValues(){
  _emailController.clear();
  passwordController.clear();
}


// saveUserNamePassword(){
//   SessionManager.setUsername = userNameController.text;
//   SessionManager.setPassword = passwordController.text;
// }

// clearUserNamePassword(){
//   SessionManager.setUsername = '';
//   SessionManager.setPassword = '';
// }

checkValidation(){
  if(formKey.currentState!.validate()){
    callApiFunction();
  }
  else{
    print('elses');
  }
}

callApiFunction()async{
  TextfieldUtils.hideKeyboard();
  final data = {
    'email_id':emailController.text,
    'password':passwordController.text
  };
  updateLoading(true);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.loginUrl, method: ApiMethod.post.name,data:data);
   updateLoading(false);
   if(response!=null){
    emailController.clear();
    passwordController.clear();
    LoginResponseModel model = LoginResponseModel.fromJson(response.data);
    LocalSharePreference.setToken = model.data[0].accessToken;
    LocalSharePreference.setEmpId = model.data[0].employeeId;
    LocalSharePreference.setUserRole = model.data[0].role;
    LocalSharePreference.setUserName = model.data[0].fullName;
    AppRouter.pushReplacementNavigation(AppNavigationScreen(
    ));
   }
  
}

}
