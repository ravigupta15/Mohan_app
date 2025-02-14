import 'package:mohan_impex/features/app_navigation/riverpod/app_navigation_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class AppNavigationState {
  final bool isLoading;
  AppNavigationState({required this.isLoading,});

  AppNavigationState copyWith({  bool? isLoading, }) {
    return AppNavigationState(
      isLoading: isLoading??this.isLoading,
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final appNavigationProvider = StateNotifierProvider<AppNavigationNotifier, AppNavigationState>(
  (ref) => AppNavigationNotifier(),
);
