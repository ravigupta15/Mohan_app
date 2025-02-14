import 'package:mohan_impex/features/auth/sign-in/riverpod/sign_in_notifier.dart';
import 'package:riverpod/riverpod.dart';

// Define a class to hold the multiple state variables
class SignInState {
  final String userName;
  final String password; // Store email as a string
  final bool isLoading;
  final bool isVisible;
  final bool isCheckBox;

  SignInState({required this.userName, required this.password, required this.isCheckBox, required this.isLoading, required this.isVisible});

  SignInState copyWith({String? userName, String? password, bool? isLoading, bool?isVisible,bool?isCheckBox}) {
    return SignInState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isLoading: isLoading??this.isLoading,
      isVisible: isVisible??this.isVisible,
      isCheckBox: isCheckBox??this.isCheckBox
    );
  }
}



// Define a StateNotifierProvider for the CounterNotifier
final signInProvider = StateNotifierProvider<SignInNotifier, SignInState>(
  (ref) => SignInNotifier(),
);
