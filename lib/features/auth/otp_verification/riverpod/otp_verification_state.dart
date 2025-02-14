import 'package:mohan_impex/features/auth/otp_verification/riverpod/otp_verification_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class OtpVerificationState {
  final bool isLoading;
  final String email;
  OtpVerificationState({  required this.isLoading, required this.email});

  OtpVerificationState copyWith({ bool? isResedEnable, bool? isLoading, int? counter, int? resendCounter, String? email}) {
    return OtpVerificationState(
      isLoading: isLoading??this.isLoading,
      email: email??this.email
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final otpProvider = StateNotifierProvider<OtpVerificationNotifier, OtpVerificationState>(
  (ref) => OtpVerificationNotifier(),
);
