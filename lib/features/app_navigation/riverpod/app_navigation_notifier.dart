// Define a StateNotifier to manage the state
import 'package:mohan_impex/features/app_navigation/riverpod/app_navigation_state.dart';
import 'package:riverpod/riverpod.dart';


class AppNavigationNotifier extends StateNotifier<AppNavigationState> {
  AppNavigationNotifier() : super(AppNavigationState(isLoading: false));
 

}
