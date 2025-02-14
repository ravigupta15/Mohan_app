import 'package:mohan_impex/features/auth/forgot_pasword/riverpod/forgot_password_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class FogotPasswordState {
  final bool isLoading;
  FogotPasswordState({required this.isLoading,});

  FogotPasswordState copyWith({  bool? isLoading, }) {
    return FogotPasswordState(
      isLoading: isLoading??this.isLoading,
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final forgotProvider = StateNotifierProvider<ForgotPasswordNotifier, FogotPasswordState>(
  (ref) => ForgotPasswordNotifier(),
);
