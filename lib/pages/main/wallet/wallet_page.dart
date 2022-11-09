import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/models/transactions.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/pages/main/wallet/all_transactions._list.dart';

import '../../../components/alert.dart';
import '../../../storage/storage.dart';

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Wallet",
          style: TextStyle(
              fontSize: 17.5, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: WalletWidget(),
    );
  }
}

class WalletWidget extends StatefulWidget {
  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  Razorpay razorpay = Razorpay();

  List<Transactions> transactions = [];

  int page = 1;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    // monitor network fetch
    page = 1;
    final response = await ApiProvider.instance.getTransactions(page);
    if (response.status ?? false) {
      transactions = response.transactions ?? [];
      setState(() {});
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshCompleted();
    }

    // if failed,use refreshFailed()
  }

  void _onLoading() async {
    // monitor network fetch
    page = 1;
    final response = await ApiProvider.instance.getTransactions(page);
    if (response.status ?? false) {
      transactions = response.transactions ?? [];
      setState(() {});
      _refreshController.loadComplete();
    } else {
      _refreshController.loadFailed();
    }
  }
  // void onRefresh() async {
  //   // monitor network fetch

  //   final response = await ApiProvider.instance.getTransactions(page);
  //   if (response.status ?? false) {
  //     setState(() {
  //       transactions = response.transactions ?? [];
  //       print('trans$transactions');
  //     });

  //     // setState(() {});
  //     // _refreshController.refreshCompleted();
  //   } else {
  //     // _refreshController.refreshFailed();
  //   }

  //   // if failed,use refreshFailed()
  // }

  @override
  void initState() {
    listenRazorPayEvents();
    super.initState();

    //  onRefresh();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Available Balance",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "\u{20B9}",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        Storage.instance.profile?.wallet ?? "500",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Button(
                  text: "Add Money",
                  onPressed: () async {
                    final amount =
                        await Navigation.instance.navigate("/addMoney");
                    if (amount != null) {
                      initPayment(amount);
                    }
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Recents",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllTransactionsPage()));
                    },
                    child: Text(
                      "View All",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: transactions.length == 1 ? 1 : 2,
              itemBuilder: (context, pos) {
                if (transactions.isNotEmpty) {
                  var current = transactions[pos];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blueGrey.shade50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              current.created_at.toString().substring(0, 10),
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                            // const SizedBox(
                            //   width: 106,
                            // ),
                            Align(
                              //alignment: Alignment.centerRight,
                              child: Text(
                                (current.statu != 'success') ? "" : "Success",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.green),
                                // (current.statu != 'success')
                                //     ? Colors.black
                                //     : Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 16),
                          itemCount: current.bonus_amount == 0 ? 1 : 2,
                          itemBuilder: (context, pos) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          (pos == 1)
                                              ? 'Bonus'
                                              : current.description.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      
                                      Text(
                                        "\u{20B9}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: Colors.black),
                                        // (current.statu != 'success')
                                        //     ? Colors.black
                                        //     : Colors.green),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        (pos == 1)
                                            ? current.bonus_amount.toString()
                                            : current.amount.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                if (pos == 0)
                                  Divider(
                                    color: Colors.grey.shade400,
                                    height: 1,
                                  ),
                                if (pos == 0)
                                  const SizedBox(
                                    height: 16,
                                  ),
                              ],
                            );
                          })
                    ],
                  );
                } else {
                  return Text('');
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void listenRazorPayEvents() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      _handlePaymentSuccess(response);
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void initPayment(amount) async {
    final response = await ApiProvider.instance.getToken(amount);
    if (response.status ?? false) {
      var options = {
        'key': response.generateToken!.razorpayId,
        'amount': response.generateToken!.amount,
        'name': Storage.instance.profile?.name,
        'order_id': response.generateToken!.orderId,
        'description': response.generateToken!.description,
        'prefill': {
          'contact': Storage.instance.profile?.phone,
          // 'email': Storage.instance.user?.email
        },
        // 'external': {
        // 'wallets': ['paytm']
        // },
      };
      try {
        razorpay.open(options);
      } catch (e) {
        print(e);
      }
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse respo) async {
    final response = await ApiProvider.instance
        .completePayment(respo.paymentId, respo.orderId, respo.signature);
    if (response.status ?? false) {
      Fluttertoast.showToast(
          msg: "Payment successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
      fetchProfile();
    }
  }

  void _handlePaymentError(PaymentFailureResponse failureResponse) {
    // RazorPayFailureResponse response = RazorPayFailureResponse.fromJson(jsonDecode(failureResponse.message!));
    //  showError(failureResponse.message!.substring(37) ?? "Something went wrong");
    showError('Payment Failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void showError(String msg) {
    AlertX.instance.showAlert(
        title: "Error",
        msg: msg,
        positiveButtonText: "Done",
        positiveButtonPressed: () {
          Navigation.instance.goBack();
        });
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
}
