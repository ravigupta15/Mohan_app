import 'package:mohan_impex/features/auth/reset_password/riverpod/reset_password_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class ResetPasswordState {
  final bool isLoading;
  final bool isVisible;
  final bool isConfirmVisible;

  ResetPasswordState({required this.isConfirmVisible,  required this.isLoading, required this.isVisible});

  ResetPasswordState copyWith({ bool? isLoading, bool?isVisible,bool?isConfirmVisible}) {
    return ResetPasswordState(
      isLoading: isLoading??this.isLoading,
      isVisible: isVisible??this.isVisible,
      isConfirmVisible: isConfirmVisible?? this.isConfirmVisible
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final resetPasswordProvider = StateNotifierProvider<ResetPasswordNotifier, ResetPasswordState>(
  (ref) => ResetPasswordNotifier(),
);
