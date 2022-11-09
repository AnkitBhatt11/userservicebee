import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:service_bee/main.dart';
import 'package:service_bee/pages/login/verifyOtp/verify_otp_bloc.dart';

import '../../../constants.dart';
import '../../../navigation/navigation.dart';

class VerifyOtpPage extends StatelessWidget {
  String mobile;
  VerifyOtpPage(this.mobile);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider<VerifyOtpCubit>(
          create: (context) => VerifyOtpCubit(),
          child: VerifyOtpWidget(mobile),
        ));
  }
}

class VerifyOtpWidget extends StatefulWidget {
  String mobile;
  VerifyOtpWidget(this.mobile);
  @override
  State<VerifyOtpWidget> createState() => _VerifyOtpWidgetState();
}

class _VerifyOtpWidgetState extends State<VerifyOtpWidget> {
  late VerifyOtpCubit verifyOtpCubit;

  Widget otpField(BuildContext context) {
    return PinCodeTextField(
      keyboardType: TextInputType.phone,
      onChanged: (val) {},
      mainAxisAlignment: MainAxisAlignment.center,
      length: 6,
      textStyle: const TextStyle(fontSize: 16, color: Colors.black),
      enablePinAutofill: true,
      enabled: true,
      enableActiveFill: true,
      controller: verifyOtpCubit.controller,
      pinTheme: PinTheme(
          borderRadius: BorderRadius.circular(6),
          selectedColor: Colors.grey.shade200,
          selectedFillColor: Colors.grey.shade200,
          activeColor: Colors.grey.shade200,
          activeFillColor: Colors.grey.shade200,
          inactiveColor: Colors.grey.shade200,
          inactiveFillColor: Colors.grey.shade200,
          fieldHeight: 40,
          fieldWidth: 40,
          fieldOuterPadding: const EdgeInsets.only(right: 12)),
      appContext: context,
    );
  }

  @override
  void initState() {
    super.initState();
    token();
    verifyOtpCubit = BlocProvider.of<VerifyOtpCubit>(context);
    verifyOtpCubit.listenOtp();
  }

  String? fcmtoken;
  token() async {
    fcmtoken = await firebaseMessaging.getToken();
    print('fcm token : $fcmtoken');
  }

  @override
  void dispose() {
    verifyOtpCubit.unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Text(
              "Enter verification code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "We have sent you a 6 digit verification code on +91 ${widget.mobile}",
                style: TextStyle(
                    color: Colors.grey.shade700, fontSize: 12, height: 1.6),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            otpField(context),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                verifyOtpCubit.verifyOtp(widget.mobile, fcmtoken!);
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              minWidth: double.infinity,
              height: 48,
              color: Constants.yellowColor,
              child: const Text(
                "Login",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
