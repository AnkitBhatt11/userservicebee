import 'package:service_bee/models/city_to_city.dart';
import 'package:service_bee/models/lead.dart';
import 'package:service_bee/models/profile.dart';
import 'package:service_bee/models/purchase_leads.dart';
import 'package:service_bee/models/quot.dart';
import 'package:service_bee/models/service_item.dart';
import 'package:service_bee/models/video_ad.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/banner.dart';
import '../models/category_item.dart';
import '../models/common_recharge_amount.dart';

class Storage {
  Storage._();

  static final Storage instance = Storage._();
  List<ServiceItem> selected = [];
  List<Map<String, Object>> maps = [];
  late SharedPreferences sharedPreferences;
  List<ServiceItem> selectedServices = [];
  Profile? profile;
  CityToCity? city;
  List<CategoryItem> categories = [];
  List<Lead> leads = [];
  List<PurchaseLeads> purchaseLeads = [];
  List<Quot> quots = [];
  List<Banner> banners = [];
  List<Banner> textBanners = [];
  List<VideoAd> videoads = [];
  List<CommonRechargeAmount> rechargeAmounts = [];

  Future<void> setProfile(Profile prof) async {
    profile = prof;
    print(prof.name);
    print('Profile Set');
  }

  // Future<void> setcity(List <CityToCity>city) async {
  //  for( var i in Storage.instance.selected){
  //  i.city2city = city ;
  //  }
  // }

  Future<void> setRechargeAmounts(List<CommonRechargeAmount> list) async {
    rechargeAmounts = list;
  }

  Future<void> setLeads(List<Lead> list) async {
    leads = list;
  }

  Future<void> setVideo(List<VideoAd> list) async {
    videoads = list;
  }

  Future<void> setBanners(List<Banner>? list) async {
    banners = list ?? [];
  }

  Future<void> setTextBanners(List<Banner>? list) async {
    textBanners = list ?? [];
  }

  Future<void> setCategories(List<CategoryItem> list) async {
    categories = list;
  }

  Future<void> initializeStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setSelected(List<ServiceItem> list) async {
    selectedServices = list;
    selected = list;
  }

  Future<void> setUser(String tokenVal) async {
    await sharedPreferences.setString("token", tokenVal);
    await sharedPreferences.setBool("isLoggedIn", true);
  }

  get isLoggedIn => sharedPreferences.getBool("isLoggedIn") ?? false;

  get token => sharedPreferences.getString("token") ?? "";

  void setPurchaseLeads(List<PurchaseLeads> list) {
    purchaseLeads = list;
  }

  Future<void> clearTokens() async {
    await sharedPreferences.clear();
  }

  void setQuot(List<Quot> list) {
    quots = list;
  }
}
