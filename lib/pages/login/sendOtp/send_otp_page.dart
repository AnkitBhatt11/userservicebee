import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/pages/login/sendOtp/send_otp_bloc.dart';
import 'package:service_bee/pages/login/verifyOtp/verify_otp_page.dart';

class SendOtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<SendOtpCubit>(
        create: (context) => SendOtpCubit(),
        child: SendOtpWidget(),
      ),
    );
  }
}

class SendOtpWidget extends StatelessWidget {
  late SendOtpCubit sendOtpCubit;
  @override
  Widget build(BuildContext context) {
    sendOtpCubit = BlocProvider.of<SendOtpCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                    ),
                    Container(
                      height: 150,
                      width: 200,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    _loginTextUI(context),
                    _countryView(context),
                    _getSignUpButtonUI(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50, bottom: 30),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'By continuing you are agreeing to',
                              style: GoogleFonts.roboto(
                                color: Colors.black45,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'our terms of use and privacy policy',
                              style: GoogleFonts.roboto(
                                color: Colors.black45,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   sendOtpCubit = BlocProvider.of<SendOtpCubit>(context);
  //   return Center(
  //       child: SingleChildScrollView(
  //         padding: const EdgeInsets.symmetric(horizontal: 24),
  //         physics: const BouncingScrollPhysics(),
  //         child: Column(
  //           children: [
  //             Image.asset("assets/images/logo.png",height: 200,fit: BoxFit.cover,),
  //             const Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text("Mobile number",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
  //             ),
  //             const SizedBox(height: 16,),
  //             TextField(
  //               keyboardType: TextInputType.phone,
  //               style: const TextStyle(color: Colors.black,fontFamily: "Montserrat"),
  //               maxLength: 10,
  //               controller: sendOtpCubit.mobileController,
  //               decoration: InputDecoration(
  //                   counterText: "",
  //                   hintText: "Enter mobile number",
  //                   fillColor: Colors.grey.shade100,
  //                   filled: true,
  //                   hintStyle: const TextStyle(color: Colors.grey,fontFamily: "Montserrat"),
  //                   enabledBorder:  OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(4),
  //                       borderSide: BorderSide(color: Colors.grey.shade100)
  //                   ),
  //                   focusedBorder:  OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(4),
  //                       borderSide: BorderSide(color: Colors.grey.shade100)
  //                   ),
  //                   contentPadding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16)
  //               ),
  //             ),
  //             const SizedBox(height: 20,),
  //             MaterialButton(
  //               onPressed: (){
  //                 sendOtpCubit.sendOtp();
  //               },
  //               elevation: 0,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(4)
  //               ),
  //               minWidth: double.infinity,
  //               height: 48,
  //               color: Constants.yellowColor,
  //               child: const Text("Get Otp",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),),
  //             ),
  //             const SizedBox(height: 20,),
  //             Text("By continuing you are agree to our\nterms and conditions and privacy policy",style: TextStyle(color: Colors.grey.shade700, fontSize: 12, height: 1.6),textAlign: TextAlign.center,),
  //             const SizedBox(height: 50,),
  //           ],
  //         ),
  //       ),
  //   );
  // }

  Widget _loginTextUI(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 16, bottom: 20),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Mobile Number',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'proxima',
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _countryView(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Theme.of(context).dividerColor, width: 0.6),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 60,
              child: Center(child: Text('+91')),
            ),
            Container(
              color: Theme.of(context).dividerColor,
              height: 32,
              width: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 16),
                child: Container(
                  color: Colors.white,
                  height: 48,
                  child: TextField(
                    controller: sendOtpCubit.mobileController,
                    maxLines: 1,
                    // onChanged: (String txt) {
                    //   sendOtpCubit.mobileController.text = txt;
                    // },
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    cursorColor: Constants.yellowColor,
                    decoration: new InputDecoration(
                      errorText: null,
                      border: InputBorder.none,
                      hintText: " Phone Number",
                      hintStyle:
                          TextStyle(color: Theme.of(context).disabledColor),
                    ),
                    keyboardType: TextInputType.phone,
                    //inputFormatters: <TextInputFormatter>[],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSignUpButtonUI(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Constants.yellowColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () {
              if (sendOtpCubit.mobileController.text.isNotEmpty &&
                  sendOtpCubit.mobileController.text.length == 10) {
                sendOtpCubit.sendOtp();
                //  send_otp(context);
              } else {
                Fluttertoast.showToast(
                    msg: "Enter a valid mobile phone number",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Center(
              child: Text(
                'Next',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getCountryString(String str) {
    var newString = '';
    var isFirstdot = false;
    for (var i = 0; i < str.length; i++) {
      if (isFirstdot == false) {
        if (str[i] != ',') {
          newString = newString + str[i];
        } else {
          isFirstdot = true;
        }
      }
    }
    return newString;
  }

  //void send_otp(context) {
  //   sendOtpCubit.sendOtp().then((_) {
  //     if (_ == 'Otp sent Successfully') {
  //       Fluttertoast.showToast(
  //           msg: "${_}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (BuildContext context) {
  //         return VerifyOtpPage(sendOtpCubit.mobileController.text);
  //       }));
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "${_}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.black,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   });
  // }
}
