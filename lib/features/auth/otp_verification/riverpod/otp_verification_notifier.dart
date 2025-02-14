// Define a StateNotifier to manage the state
import 'dart:async';
import 'package:mohan_impex/api_config/api_urls.dart';
import 'package:mohan_impex/features/auth/forgot_pasword/model/forgot_password_response_model.dart';
import 'package:mohan_impex/features/auth/otp_verification/model/otp_response_model.dart';
import 'package:mohan_impex/features/auth/otp_verification/riverpod/otp_verification_state.dart';
import 'package:mohan_impex/features/auth/reset_password/pages/reset_password_screen.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/utils/message_helper.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../api_config/api_service.dart';

class OtpVerificationNotifier extends StateNotifier<OtpVerificationState> {
  OtpVerificationNotifier() : super(OtpVerificationState(isLoading: false,email: ''));
 





setInitalValues({required String email,}){ 
  state = state.copyWith(
    email: email
  );
}

updateLoading(bool value){
  state= state.copyWith(isLoading: value);
}



callApiFunction(String otp)async{
  TextfieldUtils.hideKeyboard();
  final data = {
    "otp": otp,
  };
  updateLoading(true);
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.otpVerifyUrl, method: ApiMethod.post.name,data:data);
   updateLoading(false);
   if(response!=null){
    OtpResponseModel model = OtpResponseModel.fromJson(response.data);
    AppRouter.pushCupertinoNavigation( ResetPasswordScreen(
      resetPasswordKey: (model.data?[0].resetPasswordKey??""),
    ));
   }
  
}

Future resendApiFunction(String email)async{
  TextfieldUtils.hideKeyboard();
  final data = {
    "email_id": email,
  };
  final response = await ApiService().makeRequest(apiUrl: ApiUrls.generateOtpUrl, method: ApiMethod.post.name,data:data);
   if(response!=null){
    ForgotPasswordResponseModel model = ForgotPasswordResponseModel.fromJson(response.data);
    MessageHelper.showToast(model.message);
    return response;
   }
}


}
