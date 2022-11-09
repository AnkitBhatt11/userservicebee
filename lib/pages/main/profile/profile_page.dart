import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_bee/models/profile_item.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/pages/main/profile/edit_profile.dart';
import 'package:service_bee/storage/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 17.5, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: ProfileWidget(),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  List<ProfileItem> items = [
    ProfileItem(
        title: "Account Settings",
        subtitle: "Change account settings",
        image: "assets/images/account.png"),
    ProfileItem(
        title: "Notification",
        subtitle: "Change notification settings",
        image: "assets/images/notification.png"),
    ProfileItem(
        title: "Reviews",
        subtitle: "Your previous reviews",
        image: "assets/images/review.png"),
    ProfileItem(
        title: "Help & Support",
        subtitle: "Get help with your account",
        image: "assets/images/help.png"),
    ProfileItem(
        title: "Join our Telegram channel",
        subtitle: "Get updated with latest information",
        image: "assets/images/telegram.png"),
    ProfileItem(
        title: "Follow our Facebook page",
        subtitle: "Stay connected with us",
        image: "assets/images/facebook.png"),
    ProfileItem(
        title: "Share our app",
        subtitle: "Share Service Bee to your friends",
        image: "assets/images/share.png"),
    ProfileItem(
        title: "About Service Bee",
        subtitle: "About, Terms of use, Privacy Policy",
        image: "assets/images/about.png"),
    ProfileItem(
        title: "App Feedback",
        subtitle: "Help us improve your experience",
        image: "assets/images/review.png"),
    ProfileItem(
        title: "Deactivate Account",
        subtitle: "Request your account to be deactivated",
        image: "assets/images/about.png"),
    ProfileItem(
        title: "Logout",
        subtitle: "Sign out of your account",
        image: "assets/images/help.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, pos) {
        ProfileItem item = items[pos];
        return GestureDetector(
          onTap: () {
            nav_to(pos, context);
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        AssetImage(item.image),
                        color: Colors.grey.shade700,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                  fontSize: 14.5, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              item.subtitle,
                              style: TextStyle(
                                  fontSize: 12.5, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void nav_to(int pos, context) {
    switch (pos) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditProfile()));
       // Navigation.instance.navigate('/editProfile');
        break;
      case 1:
        Navigation.instance.navigate('/notificationPage');
        break;
      case 2:
        Navigation.instance.navigate('/reviews');
        break;
      case 3:
        Navigation.instance.navigate('/HelpSupport');
        break;
      case 7:
        Navigation.instance.navigate('/aboutPage');
        break;
      case 9:
        Navigation.instance.navigate('/deactivate');
        // requestDeactivate();
        break;
      case 10:
        print("here");
        Storage.instance.clearTokens();
        Navigation.instance.navigate('/');
        break;
      case 2:
        final Uri params = Uri(
          scheme: 'mailto',
          path: 'riders.bikerscab@gmail.com',
          query:
              'subject=App Feedback&body=App Version 3.23', //add subject and body here
        );
        sendEmail(params);
        //riders.bikerscab@gmail.com
        break;
      default:
        break;
    }
  }

  sendEmail(params) async {
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void requestDeactivate() async {
    final request = await ApiProvider.instance.delete_account_request();
    if (request.status ?? false) {
      Fluttertoast.showToast(msg: request.message ?? "");
    }
  }
}
