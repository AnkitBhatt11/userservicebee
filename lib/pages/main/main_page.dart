import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:service_bee/main.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/pages/main/home/home_page.dart';
import 'package:service_bee/pages/main/leads/leads_page.dart';
import 'package:service_bee/pages/main/profile/profile_page.dart';
import 'package:service_bee/pages/main/wallet/wallet_page.dart';
import 'package:service_bee/storage/storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //  navigate();
    // fetchProfile();
    // fetchLeads();
    // fetchPurchaseLeads();
    // fetchQuot();
  }

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget bodyWidget() {
    if (_currentIndex == 0) {
      return HomePage();
    } else if (_currentIndex == 1) {
      return LeadsPage();
    } else if (_currentIndex == 2) {
      return WalletPage();
    } else {
      return ProfilePage();
    }
  }

  void navigate() {
    // Timer(const Duration(seconds: 2), () {
    if (Storage.instance.isLoggedIn) {
      checkProfile();
    } else {
      Navigation.instance.navigateAndRemoveUntil("/gettingstarted");
    }
    //  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBarTheme(
        data: const BottomNavigationBarThemeData(backgroundColor: Colors.white),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: changeIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          iconSize: 22,
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/home.png")),
                label: "Home"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/leads.png")),
                label: "Leads"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/wallet.png")),
                label: "Wallet"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/user.png")),
                label: "Profile"),
          ],
        ),
      ),
      body: bodyWidget(),
    );
  }

  void checkProfile() async {
    //String? token = await firebaseMessaging.getToken();
    //print('fcm token : $token');
    final response = await ApiProvider.instance.checkProfile();
    if (response.exists ?? false) {
    //  print('fcm token : $token');
      print('sbsbsbs');
      print('not checked');
      fetchProfile();
      fetchLeads();
      fetchPurchaseLeads();
      fetchQuot();
      //   final response1 = await ApiProvider.instance.getServices();
      //   if (response1.status ?? false) {
      //     Storage.instance.setSelected(response1.services ?? []);
      //     Navigation.instance.navigateAndRemoveUntil("/main");
      //   } else {
      //     Navigation.instance.navigateAndRemoveUntil("/main");
      //   }
      // } else {
      //   print('checked');
      //   Navigation.instance.navigateAndRemoveUntil("/category");
      // }
    }
  }

  void fetchProfile() async {
    // String? token = await firebaseMessaging.getToken();
    // print('fcm token : $token');
    final response = await ApiProvider.instance.fetchProfile();
    if (response.status ?? false) {
      print('rg brb');
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
