import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/alert.dart';
import '../../../navigation/navigation.dart';
import '../../../storage/storage.dart';

class LeadsPage extends StatefulWidget {
  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  int currentIndex = 0;

  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchLeads();
    fetchPurchaseLeads();
    fetchQuot();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  String message = '';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                //  width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: TabBar(
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat"),
                  unselectedLabelStyle:
                      const TextStyle(fontSize: 13.5, fontFamily: "Montserrat"),
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: "New Leads  ",
                    ),
                    Tab(
                      text: "Purchased Leads",
                    ),
                    Tab(
                      text: "Quotation  ",
                    ),
                  ],
                ),
              ),
            ),
            title: const Text(
              "Leads",
              style: TextStyle(
                  fontSize: 17.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            itemCount: getList(currentIndex).length,
            itemBuilder: (context, pos) {
              var data = getList(currentIndex)[pos];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          currentIndex == 0
                              ? 'Looking for ${data.service} '
                              : data.name,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        // Expanded(
                        //     child: Text(
                        //   "looking for AC installation",
                        //   style: TextStyle(
                        //       fontSize: 13, color: Colors.grey.shade700),
                        // )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Constants.yellowColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          //data.data == null           changesddddddddddddddddddddddddddddddddddddddddddddddddddd
                          data.date == null
                              ? ''
                              : '${data.date.toString().substring(8, 10)}' +
                                  '-' +
                                  '${data.date.toString().substring(5, 7)}' +
                                  '-' +
                                  '${data.date.toString().substring(0, 4)}',
                          // data.date ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade900,
                              height: 1.6),
                        )),
                        Icon(
                          Icons.timer_rounded,
                          color: Constants.yellowColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(
                          //data.data == null           changesddddddddddddddddddddddddddddddddddddddddddddddddddd
                          data.date == null
                              ? ''
                              : '${data.date.toString().substring(11, 16)}',
                          // data.date ?? "",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade900,
                              height: 1.6),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (currentIndex == 0)
                      if (data.type == 2)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Constants.yellowColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'From :',
                              style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.75),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                                child: Text(
                              data.city_from ?? "",
                              style: TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.grey.shade900,
                                  height: 1.75),
                            )),
                          ],
                        ),
                    if (currentIndex == 0)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Constants.yellowColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            data.type == 2
                                ? 'To :'
                                : data.type == 1
                                    ? 'Pincode :'
                                    : 'Location :',
                            style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.75),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                              child: Text(
                            data.city ?? "",
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade900,
                                height: 1.75),
                          )),
                        ],
                      ),
                    if (currentIndex != 0)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Constants.yellowColor,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: Text(
                            data.address ?? "",
                            style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.grey.shade900,
                                height: 1.75),
                          )),
                        ],
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (currentIndex == 0)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              if (Storage.instance.profile?.document_status ==
                                  "verified") {
                                print("veriifed");
                                message = await showPhotoBottomSheet(
                                    data.quote_rate ?? 0, data.query_id ?? 0);
                                print('hogya$message');
                              } else {
                                showError("Documents not verified !");
                              }
                              // sendQuote(
                              //     data.quote_rate ?? 0, data.query_id ?? 0);
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: 0,
                            height: 32,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            child: Text(
                              "Send quote \u{20B9}${data.quote_rate ?? 0}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
                          const Spacer(),
                          MaterialButton(
                            onPressed: () {
                              if (Storage.instance.profile?.document_status ==
                                  "verified") {
                                sendPurchaseLeads(data.query_id ?? 0);
                              } else {
                                showError("Documents not verified !");
                              }
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: 0,
                            height: 32,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            child: Text(
                              "Buy Leads \u{20B9}${data.purchase_rate ?? 0}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      )
                    else if (currentIndex == 1)
                      Row(
                        children: [
                          const Icon(
                            Icons.phone_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                launch('tel://${data.phno}');
                              },
                              child: Text(
                                data.phno,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              // show(data);
                              show(data.query_id);
                              // sendPurchaseLeads(data.query_id ?? 0);
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: 0,
                            height: 32,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            child: const Text(
                              "Verify Leads",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      )
                    else
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Quotation :  ${data.message}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  // show(data);
                                  show(data.query_id);
                                  // sendPurchaseLeads(data.query_id ?? 0);
                                },
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                                height: 32,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                child: const Text(
                                  "Verify Leads",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (Storage
                                          .instance.profile?.document_status ==
                                      "verified") {
                                    sendPurchaseLeads(data.query_id);
                                  } else {
                                    showError("Documents not verified !");
                                  }
                                },
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                elevation: 0,
                                height: 32,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                child: Text(
                                  "Buy Leads ",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  void sendQuote(int quote_rate, int query_id, String message) async {
    final response =
        await ApiProvider.instance.sendQuote(quote_rate, query_id, message);
    if (response.status ?? false) {
      Fluttertoast.showToast(msg: response.message ?? "Successfull");
      fetchLeads();
      fetchPurchaseLeads();
      fetchQuot();
    } else {
      showError(response.message ?? "Something Went Wrong");
    }
  }

  void sendPurchaseLeads(int query_id) async {
    final response = await ApiProvider.instance.sendPurchaseLeads(query_id);
    if (response.status ?? false) {
      Fluttertoast.showToast(msg: response.message ?? "Successfull");
      fetchLeads();
      fetchPurchaseLeads();
      fetchQuot();
    } else {
      showError(response.message ?? "Something Went Wrong");
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

  void fetchPurchaseLeads() async {
    final response = await ApiProvider.instance.getPurchaseLeads();
    if (response.status ?? false) {
      Storage.instance.setPurchaseLeads(response.purchaseLeads ?? []);
      setState(() {});
    } else {}
  }

  void fetchQuot() async {
    final response = await ApiProvider.instance.getQuot();
    print('QUOT ${response.status}');
    print('QUOT  ${response.quotes}');
    if (response.status ?? false) {
      Storage.instance.setQuot(response.quotes ?? []);
      setState(() {});
    } else {}
  }

  show(id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter the pin"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter the otp",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: const TextStyle(
                          color: Colors.grey, fontFamily: "Montserrat"),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                      contentPadding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 16)),
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      verifyOtp(id.toString(), controller.text.toString());
                    }
                    // show();
                    // sendPurchaseLeads(data.query_id ?? 0);
                  },
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                  height: 32,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        });
  }

  getList(int currentIndex) {
    switch (currentIndex) {
      case 1:
        print('1');
        return Storage.instance.purchaseLeads;
      case 2:
        print('2 ${Storage.instance.quots.length}');
        return Storage.instance.quots;
      default:
        print('0');
        return Storage.instance.leads;
    }
  }

  void verifyOtp(String id, pin) async {
    final response = await ApiProvider.instance.verifyLeads(id, pin);
    if (response.status ?? false) {
      // Navigation.instance.goBack();
      Fluttertoast.showToast(msg: response.message ?? "Success");
      fetchLeads();
      fetchPurchaseLeads();
      fetchQuot();
      Navigation.instance.goBack();
    } else {
      Fluttertoast.showToast(msg: response.message ?? "Failed");
      fetchLeads();
      fetchPurchaseLeads();
      fetchQuot();
      Navigation.instance.goBack();
    }
  }

  void fetchLeads() async {
    final response = await ApiProvider.instance.getLeads();
    if (response.status ?? false) {
      setState(() {
        Storage.instance.setLeads(response.leads ?? []);
      });
    } else {}
  }

  Future<String> showPhotoBottomSheet(var rate, var id) {
    TextEditingController con = TextEditingController();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    var res;
    BuildContext? context = Navigation.instance.navigatorKey.currentContext;
    if (context != null) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Center(
                    child: Text(
                  "Add Quotation",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                )),
                contentPadding: EdgeInsets.only(top: 12, bottom: 12),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: TextFormField(
                        controller: con,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.grey.shade900,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.grey.shade800,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {
                                res = con.text;
                              });
                              if (res == '' || res == null) {
                                Fluttertoast.showToast(msg: 'Enter quotation');
                              } else {
                                sendQuote(rate, id, res);
                                Navigation.instance.goBack();
                              } //  getImage(0);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.pink.shade300),
                                  child: Text('Send',
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                // Text("Camera",
                                //     style: TextStyle(
                                //       fontSize: 14,
                                //     )),
                              ],
                            )),
                        // SizedBox(
                        //   width: 42,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       Navigation.instance.goBack();
                        //       getImage(1);
                        //     },
                        //     child: Column(
                        //       children: [
                        //         Container(
                        //           padding: EdgeInsets.all(12),
                        //           margin: EdgeInsets.only(bottom: 4),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(30),
                        //               color: Colors.purple.shade300),
                        //           child: Icon(
                        //             EvaIcons.image,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //         Text("Gallery",
                        //             style: TextStyle(
                        //               fontSize: 14,
                        //             )),
                        //       ],
                        //     )),
                      ],
                    ),
                  ],
                ));
          });
    }
    return res;
  }
}
