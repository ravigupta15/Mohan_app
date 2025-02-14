import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 final GlobalKey<NavigatorState> navigatorKey=
      GlobalKey<NavigatorState>();

class AppRouter {
  static Future pushCupertinoNavigation(
    route,
  ) {
    return Navigator.push(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route));
  }

  static pushMaterialNavigation(
    route,
  ) {
    Navigator.push(navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => route));
  }

  static pushReplacementNavigation(
    route,
  ) {
    Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
        CupertinoPageRoute(builder: (context) => route), (route) => false);
  }
}
