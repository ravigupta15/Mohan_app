import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/core/widget/app_button.dart';
import 'package:mohan_impex/core/widget/app_logo.dart';
import 'package:mohan_impex/core/widget/app_text.dart';
import 'package:mohan_impex/features/auth/otp_verification/riverpod/otp_verification_state.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_fontfamily.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String email;
  const OtpVerificationScreen({required this.email,});

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
 GlobalKey<FormState> formKey = GlobalKey<FormState>();
 TextEditingController  otpController = TextEditingController();
@override
  void initState() {
    super.initState();
    Future.microtask((){
      ref.read(otpProvider.notifier).setInitalValues(email: widget.email);
      startTimer();
    });
  }

    bool isResendLoading = false;
  int counter = 30;
  Timer? timer;
  int resendCounter = 0;  
  bool resend = false;

 void startTimer() {
    resendCounter += 1;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 1) {
        counter--;
        resend = true;
      } else {
        timer.cancel();
        resend = false;
        counter = 30;
      }
      setState(() {
        
      });
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpProvider);
    final otpNotifier = ref.read(otpProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40,left: 19,right: 19),
          child: Form(
            key:formKey,
            child: Column(
            children: [
              appLogoWidget(),
              const SizedBox(height: 40,),
              AppText(title: "OTP Verification",fontsize: 22,fontFamily: AppFontfamily.poppinsSemibold,),
              const SizedBox(height: 8,),
              Text.rich(TextSpan(
                text: "Enter the OTP sent to ",
                style: TextStyle(
                  fontSize: 16,color: AppColors.lightTextColor,
                ),children: [
                  TextSpan(
                    text:widget.email,
                    style: TextStyle(
                      color: AppColors.black,fontFamily: AppFontfamily.poppinsSemibold,
                      fontSize: 16
                    )
                  )
                ]
              )),
              const SizedBox(height: 40,),
              otpField(context),
              const SizedBox(height: 20,),
              Text.rich(TextSpan(
                text:!resend? "Didn't receive the OTP? " : "Resend code in ",
                 style: TextStyle(
                  fontSize: 14,color: AppColors.light92Color,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=(){
                      if(!resend){
                        otpNotifier.resendApiFunction(widget.email).then((val){
                          if(val!=null){
                            startTimer();
                          }
                        });
                      }
                    },
                    text:!resend? "Resend OTP" : counter.toString(),
                    style: TextStyle(
                      color: AppColors.black,fontFamily: AppFontfamily.poppinsMedium,
                      fontSize: 14
                    )
                  )
                ]
              ))

            ],
                    ),
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
         floatingActionButton:  Padding(padding: EdgeInsets.only(left: 19,right: 19,bottom: 30),
        child: AppButton(title: "Verify",height: 50,
        color: AppColors.arcticBreeze,
        isLoading: otpState.isLoading,
        onPressed: (){
          if(formKey.currentState!.validate()){
           otpNotifier.callApiFunction(otpController.text); 
          }
          // AppRouter.pushCupertinoNavigation(const ResetPasswordScreen());
        },),
        ),
    );
  }

   otpField(BuildContext context,) {
    return Center(
      child: SizedBox(
        // width: MediaQuery.sizeOf(context).width-100,
        child: PinCodeTextField(
          controller: otpController,
          autovalidateMode: AutovalidateMode.disabled,
          cursorHeight: 20,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(
              8,
            ),
            activeColor: AppColors.edColor,
            disabledColor: AppColors.edColor,
            selectedColor: AppColors.edColor,
            inactiveColor: AppColors.edColor,
            fieldHeight: 48,
            fieldWidth: 48,
            inactiveFillColor: AppColors.edColor,
            selectedFillColor: AppColors.edColor,
            activeFillColor: AppColors.edColor
          ),
          cursorColor: AppColors.black,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          length: 4,
          animationDuration: const Duration(milliseconds: 300),
          appContext: context,
          keyboardType: TextInputType.number,
          textStyle:const TextStyle(
              color: AppColors.black1, fontFamily: AppFontfamily.poppinsRegular),
          enableActiveFill: true,
          onChanged: (val) {},
          onCompleted: (result) {},
          validator: (val) {
            if (val!.isEmpty) {
              return 'Enter otp';
            } else if (val.length < 4) {
              return 'Enter otp shoulb be valid';
            }
            return null;
          },
        ),
      ),
    );
  }


}