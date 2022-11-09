import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/models/review.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/pages/main/home/banner_widget.dart';
import 'package:service_bee/pages/main/home/home_details_widget.dart';
import 'package:service_bee/pages/main/home/security_tips_widget.dart';
import 'package:service_bee/pages/main/home/tutorial_widget.dart';
import 'package:service_bee/pages/main/leads/leads_page.dart';
import 'package:service_bee/pages/main/profile/edit_profile.dart';
import 'package:service_bee/pages/main/wallet/wallet_page.dart';
import 'package:service_bee/pages/reviews/reviews.dart';
import 'package:service_bee/storage/storage.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Home",
//           style: TextStyle(
//               fontSize: 17.5, color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: HomeWidget(),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Review> reviews = [];
  int upper = 0;
  int lower = 1;
  int rating = 0;
  void fetchReviews() async {
    final response = await ApiProvider.instance.getReviews();
    if (response.status ?? false) {
      setState(() {
        reviews = response.reviews ?? [];
      });
      if (reviews.length >= 1) {
        for (int i = 0; i < reviews.length; i++) {
          upper = upper + reviews[i].rating!.toInt();
        }
        lower = 5 * reviews.length;

        setState(() {
          rating = (upper * 5 / lower).toInt();
          print('/////$rating');
        });
      } else {
        rating = 0;
      }
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // _onRefresh() async {
  //   // monitor network fetch

  //   final response = await ApiProvider.instance.fetchProfile();
  //   if (response.status ?? false) {
  //     Storage.instance.setProfile(response.profile![0]);
      
  //     _refreshController.refreshCompleted();
  //   } else {
  //     print("THIS ERROR ${response.status}");
  //     _refreshController.refreshCompleted();
  //   }
  //   // if failed,use refreshFailed()
  // }

  fetchProfile() async {
    // monitor network fetch

    final response = await ApiProvider.instance.fetchProfile();
    if (response.status ?? false) {
      Storage.instance.setProfile(response.profile![0]);
    } else {
      print("THIS ERROR ${response.status}");
      _refreshController.refreshCompleted();
    }
    // if failed,use refreshFailed()
  }

  // void _onLoading() async {
  //   // monitor network fetch
  //   final response = await ApiProvider.instance.fetchProfile();
  //   if (response.status ?? false) {
  //     print(response.profile);
  //     //  Storage.instance.setProfile(response.profile![0]);
  //     _refreshController.loadComplete();
  //   } else {
  //     print("THIS ERROR ${response.status}");
  //     _refreshController.loadFailed();
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReviews();
    fetchProfile();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Home",
          style: TextStyle(
              fontSize: 17.5, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        //   physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerWidget(),
            const SizedBox(
              height: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileSection(context),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletPage())).then((value) => Navigation.instance.navigateAndRemoveUntil('/main'));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: const LinearGradient(
                          colors: [
                            Color(0xfff95997),
                            Color(0xfffe717b),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                    ),
                    child: Row(
                      children: [
                        Container(
                            height: 54,
                            width: 54,
                            decoration: const BoxDecoration(
                                color: Colors.white24,
                                shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Text(
                              Storage.instance.profile?.wallet ?? '0',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white),
                            )),
                        const SizedBox(
                          width: 16,
                        ),
                        const Expanded(
                            child: Text(
                          "Wallet Amount",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WalletPage()));
                          },
                          color: Colors.white24,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                          height: 28,
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                leadsSection(context),
                const SizedBox(
                  height: 16,
                ),
                // locationSection(),
                // const SizedBox(
                //   height: 16,
                // ),
                ratingSection(context),
              ],
            ),
            //  HomeDetailsWidget(),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: Storage.instance.videoads.length,
                  itemBuilder: (cont, count) {
                    var ad = Storage.instance.videoads[count];
                    return TutorialWidget('${ad.url}');
                  }),
            ),
            const SizedBox(
              height: 24,
            ),
            SecurityTipsWidget(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileSection(context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfile()))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: const LinearGradient(colors: [
            Color(0xff1fdddb),
            Color(0xff5681e9),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                  color: Colors.white24, shape: BoxShape.circle),
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "Profile",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget walletSection(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WalletPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: const LinearGradient(colors: [
            Color(0xfff95997),
            Color(0xfffe717b),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Row(
          children: [
            Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                    color: Colors.white24, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  Storage.instance.profile?.wallet ?? '0',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white),
                )),
            const SizedBox(
              width: 16,
            ),
            const Expanded(
                child: Text(
              "Wallet Amount",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WalletPage()));
              },
              color: Colors.white24,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 0,
              height: 28,
              child: const Text(
                "Add",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget leadsSection(context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LeadsPage())).then((value) => Navigation.instance.navigateAndRemoveUntil('/main'))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: const LinearGradient(colors: [
            Color(0xff40d89d),
            Color(0xff3bb7b4),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Row(
          children: [
            Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                    color: Colors.white24, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  Storage.instance.purchaseLeads.length.toString() ?? '0',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white),
                )),
            const SizedBox(
              width: 16,
            ),
            const Text(
              "Purchased Leads",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget locationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: const LinearGradient(colors: [
          Color(0xffffc347),
          Color(0xfffe8956),
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      ),
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: const BoxDecoration(
                color: Colors.white24, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(
              Icons.location_on_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const Text(
            "Location",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget ratingSection(context) {
    return GestureDetector(
      onTap: (() => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Reviews())).then((value) => Navigation.instance.navigateAndRemoveUntil('/main'))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: const LinearGradient(colors: [
            Color(0xffd55cfd),
            Color(0xffb53eba),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Row(
          children: [
            Container(
                height: 54,
                width: 54,
                decoration: const BoxDecoration(
                    color: Colors.white24, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(
                  rating.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.white),
                )),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rating",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: List.generate(
                      rating,
                      (index) => const Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: 20,
                            ),
                          )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
