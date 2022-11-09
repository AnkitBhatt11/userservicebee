import 'package:flutter/material.dart';
import 'package:service_bee/components/loading_dialog.dart';
import 'package:service_bee/components/new_loading.dart';
import 'package:service_bee/getting_started.dart';
import 'package:service_bee/pages/createProfile/category/category_page.dart';
import 'package:service_bee/pages/createProfile/city_pick_page.dart';
import 'package:service_bee/pages/createProfile/document_pick_page.dart';
import 'package:service_bee/pages/createProfile/pincode_page.dart';
import 'package:service_bee/pages/createProfile/services/add_withinCity.dart';

import 'package:service_bee/pages/createProfile/services/pinpage.dart';

import 'package:service_bee/pages/delete_profile/deactivate_page.dart';
import 'package:service_bee/pages/delete_profile/final_delete_page.dart';
import 'package:service_bee/pages/login/sendOtp/send_otp_page.dart';
import 'package:service_bee/pages/login/verifyOtp/verify_otp_page.dart';
import 'package:service_bee/pages/main/HelpSupport.dart';
import 'package:service_bee/pages/main/wallet/add_money_page.dart';
import '../pages/createProfile/add_pincode_page.dart';
import '../pages/createProfile/category/category_edit_page.dart';
import '../pages/createProfile/city_pick_edit.dart';
import '../pages/createProfile/services/services_edit_page.dart';
import '../pages/createProfile/services/services_page.dart';
import '../pages/createProfile/subCategory/sub_category_edit.dart';
import '../pages/createProfile/subCategory/sub_category_page.dart';
import '../pages/main/main_page.dart';
import '../pages/main/profile/about_page.dart';
import '../pages/main/profile/edit_profile.dart';
import '../pages/notification/notification_page.dart';
import '../pages/reviews/reviews.dart';
import '../pages/splash/splash_page.dart';
import 'fade_transition_route.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return FadeTransitionPageRouteBuilder(page: SplashPage());

    //login pages
    case '/gettingstarted':
      return FadeTransitionPageRouteBuilder(page: GettingStarted());
    case '/sendOtp':
      return FadeTransitionPageRouteBuilder(page: SendOtpPage());
    case '/verifyOtp':
      return FadeTransitionPageRouteBuilder(
          page: VerifyOtpPage(settings.arguments as String));

    //createProfile
    case '/category':
      return FadeTransitionPageRouteBuilder(page: CategoryPage());
    case '/categoryEdit':
      return FadeTransitionPageRouteBuilder(page: CategoryEditPage());
    case '/subCategory':
      return FadeTransitionPageRouteBuilder(
          page: SubCategoryPage(settings.arguments as int));
    case '/subCategoryEdit':
      return FadeTransitionPageRouteBuilder(
          page: SubCategoryEditPage(settings.arguments as int));
    case '/service':
      return FadeTransitionPageRouteBuilder(
          page: ServicePage(settings.arguments as int));
    case '/serviceEdit':
      return FadeTransitionPageRouteBuilder(
          page: ServiceEditPage(settings.arguments as int));
    case '/cityPick':
      return FadeTransitionPageRouteBuilder(page: CityPickPage());
    case '/cityPickEdit':
      return FadeTransitionPageRouteBuilder(page: CityPickEditPage());
    case '/pincode':
      return FadeTransitionPageRouteBuilder(page: PincodePage());
    case '/addPincode':
      return FadeTransitionPageRouteBuilder(page: AddPincodePage());
      case '/addWithinCity':
      return FadeTransitionPageRouteBuilder(page: AddWithinCity());
    case '/documentPick':
      return FadeTransitionPageRouteBuilder(page: DocumentPickPage());
    case '/editProfile':
      return FadeTransitionPageRouteBuilder(page: EditProfile());
    case '/aboutPage':
      return FadeTransitionPageRouteBuilder(page: AboutPage());
    case '/notificationPage':
      return FadeTransitionPageRouteBuilder(page: NotificationPage());
    case '/reviews':
      return FadeTransitionPageRouteBuilder(page: Reviews());
    case '/deactivate':
      return FadeTransitionPageRouteBuilder(page: DeactivatePage());
    // case '/deleteAccount':
    //   return FadeTransitionPageRouteBuilder(page: FinalDeletePage());
    case '/HelpSupport':
      return FadeTransitionPageRouteBuilder(page: HelpSupport());
      // case '/pinpage':
      // return FadeTransitionPageRouteBuilder(page: pinpage());
      

    //main pages
    case '/main':
      return FadeTransitionPageRouteBuilder(page: const MainPage());
    case '/addMoney':
      return FadeTransitionPageRouteBuilder(page: AddMoneyPage());

    //dialogs
    case '/loadingDialog':
      return FadeTransitionPageRouteBuilder(page: LoadingDialog());
       case '/NewloadingDialog':
      return FadeTransitionPageRouteBuilder(page: NewLoadingDialog());

    default:
      return MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text('404 Page not found'),
          ),
        );
      });
  }
}
