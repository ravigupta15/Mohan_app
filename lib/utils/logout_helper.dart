import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/auth/sign-in/pages/sign_in_screen.dart';
import 'package:mohan_impex/res/app_router.dart';

class LogoutHelper {
  static logout(){
    LocalSharePreference.setToken = "";
    AppRouter.pushReplacementNavigation(const SignInScreen());
  }
}