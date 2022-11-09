import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_bee/main.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/storage/storage.dart';
import 'package:sprung/sprung.dart';
import '../../navigation/navigation.dart';

class SplashPage extends StatefulWidget {
  SplashPage() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white));
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this, value: 0);
    _animation =
        CurvedAnimation(parent: _controller, curve: Sprung.underDamped);
    _controller.forward();
    navigate();
    fetchTextBanner();
    fetchBanner();
    fetchVideoAds();
    fetchCommonRecharge();
    super.initState();
  }

  void navigate() {
    Timer(const Duration(seconds: 2), () {
      if (Storage.instance.isLoggedIn) {
        checkProfile();
      } else {
        Navigation.instance.navigateAndRemoveUntil("/gettingstarted");
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: FadeTransition(
              opacity: _animation,
              child: ScaleTransition(
                scale: _animation,
                child: Padding(
                  padding: const EdgeInsets.all(42.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: double.infinity,
                  ),
                ),
              ))),
    );
  }

  void checkProfile() async {
    final response = await ApiProvider.instance.checkProfile();
    if (response.exists ?? false) {
    //   String? token = await firebaseMessaging.getToken();
    // print('fcm token : $token');
      print('not checked');
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
      print('checked');
      Navigation.instance.navigateAndRemoveUntil("/category");
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
}




//AIzaSyDKjQNkMiD4zxpijGTrx4NuTbTxMAgYh3M