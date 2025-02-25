import 'package:flutter/material.dart';
import 'package:mohan_impex/res/loader/show_loader.dart';


class CustomNavigatorObserver extends NavigatorObserver {
  // Intercept back button press
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // When the back button is pressed, hide the loader
    ShowLoader.hideLoader();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
