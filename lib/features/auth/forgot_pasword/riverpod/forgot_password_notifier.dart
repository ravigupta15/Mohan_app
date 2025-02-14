// Define a StateNotifier to manage the state
import 'package:flutter/material.dart';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/auth/forgot_pasword/model/forgot_password_response_model.dart';
import 'package:mohan_impex/features/auth/forgot_pasword/riverpod/fogot_password_state.dart';
import 'package:mohan_impex/features/auth/otp_verification/pages/otp_verification_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../api_config/api_service.dart';

class ForgotPasswordNotifier extends StateNotifier<FogotPasswordState> {
  ForgotPasswordNotifier() : super(FogotPasswordState(isLoading: false));
 
 
  TextEditingController  emailController = TextEditingController();

 
final formKey = GlobalKey<FormState>();

setInitalValues({required String email}){
  emailController.text = email;
}

updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}



checkValidation(){
  if(formKey.currentState!.validate()){
    callApiFunction();
  }
}

callApiFunction()async{
  TextfieldUtils.hideKeyboard();
  final data = {
    "email_id": emailController.text,
  };
  updateLoading(true);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.generateOtpUrl, method: ApiMethod.post.name,data:data);
   updateLoading(false);
   if(response!=null){
    ForgotPasswordResponseModel model = ForgotPasswordResponseModel.fromJson(response.data);
    MessageHelper.showToast(model.message);
    AppRouter.pushCupertinoNavigation(OtpVerificationScreen(email: emailController.text,));
   }
}



}
