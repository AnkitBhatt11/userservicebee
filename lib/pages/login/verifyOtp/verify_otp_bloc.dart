import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_autofill/otp_autofill.dart';

import '../../../components/alert.dart';
import '../../../constants.dart';
import '../../../helpers.dart';
import '../../../navigation/navigation.dart';
import '../../../network/api_provider.dart';
import '../../../storage/storage.dart';

abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());
  late OTPTextEditController controller;
  late OTPInteractor otpInteractor;
  bool isOtpValid = false;

  Future<void> listenOtp() async {
    otpInteractor = OTPInteractor();
    otpInteractor
        .getAppSignature()
        .then((value) => print('signature - $value'));
    controller = OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) => print('Your Application receive code - $code'),
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
        strategies: [],
      );
  }

  Future<void> unregisterListener() async {
    await controller.stopListen();
  }

  Future<void> verifyOtp(String mobile , String fcmtoken) async {
    if (controller.text.length == 6) {
      var isNetworkConnection = await Helpers.isNetwork();
      if (isNetworkConnection) {
        Navigation.instance.navigate("/loadingDialog");
        final response =
            await ApiProvider.instance.verifyOtp(mobile, controller.text , fcmtoken);
        Navigation.instance.goBack();
        if (response.status ?? false) {
          await Storage.instance.setUser(response.token ?? "");
          fetchTextBanner();
          fetchBanner();
          fetchVideoAds();
          fetchCommonRecharge();
          final resp = await ApiProvider.instance.checkProfile();
          if (resp.exists ?? false) {
            fetchProfile();
            fetchLeads();
            fetchPurchaseLeads();
            fetchQuot();
            final response1 = await ApiProvider.instance.getServices();
            if (response1.status ?? false) {
              Storage.instance.setSelected(response1.services ?? []);
              Navigation.instance.navigateAndRemoveUntil("/main");
            } else {
              Navigation.instance.navigateAndRemoveUntil("/main");
            }
          } else {
            Navigation.instance.navigateAndRemoveUntil("/category");
          }
        } else {
          showError(response.message ?? "Something went wrong");
        }
      } else {
        showError(Constants.noInternet);
      }
    } else {
      showError("Invalid Otp");
    }
  }

  void fetchProfile() async {
    final response = await ApiProvider.instance.fetchProfile();
    if (response.status ?? false) {
      print(response.profile);
      Storage.instance.setProfile(response.profile![0]);
    } else {
      print("THIS ERROR ${response.status}");
    }
  }

  void fetchLeads() async {
    final response = await ApiProvider.instance.getLeads();
    if (response.status ?? false) {
      Storage.instance.setLeads(response.leads ?? []);
    } else {}
  }

  void fetchPurchaseLeads() async {
    final response = await ApiProvider.instance.getPurchaseLeads();
    if (response.status ?? false) {
      Storage.instance.setPurchaseLeads(response.purchaseLeads ?? []);
    } else {}
  }

  void fetchQuot() async {
    final response = await ApiProvider.instance.getQuot();
    if (response.status ?? false) {
      Storage.instance.setQuot(response.quotes ?? []);
    } else {}
  }

  void fetchBanner() async {
    final response = await ApiProvider.instance.getBanner();
    if (response.status ?? false) {
      Storage.instance.setBanners(response.banners);
    }
  }

  void fetchTextBanner() async {
    final response = await ApiProvider.instance.getTextBanner();
    if (response.status ?? false) {
      Storage.instance.setTextBanners(response.banners);
    }
  }

  void fetchVideoAds() async {
    final response = await ApiProvider.instance.getVideoads();
    if (response.status ?? false) {
      Storage.instance.setVideo(response.ads ?? []);
    }
  }

  void fetchCommonRecharge() async {
    final response = await ApiProvider.instance.getCommonRecharge();
    if (response.status ?? false) {
      Storage.instance.setRechargeAmounts(response.list ?? []);
    }
  }

  void showError(String msg) {
    AlertX.instance.showAlert(
        title: "Error",
        msg: msg,
        positiveButtonText: "Done",
        positiveButtonPressed: () {
          Navigation.instance.goBack();
        });
  }
}
