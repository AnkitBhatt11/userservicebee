import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_bee/components/alert.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';

class FinalDeletePage extends StatefulWidget {
  String reason;
  FinalDeletePage({required this.reason});
  //const FinalDeletePage({Key? key}) : super(key: key);

  @override
  State<FinalDeletePage> createState() => _FinalDeletePageState();
}

class _FinalDeletePageState extends State<FinalDeletePage> {
  // void requestDeactivate() async {
  //   final request = await ApiProvider.instance.delete_account_request();
  //   if (request.status ?? false) {
  //     Fluttertoast.showToast(msg: request.message ?? "");
  //   }
  // }

  @override
  void initState() {
    super.initState();
    print('deactivate');
    print(widget.reason);
  }

  TextEditingController name = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController ifcs = TextEditingController();
  TextEditingController address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Deactivate your account",
          style: Theme.of(context).textTheme.caption!.copyWith(
                letterSpacing: 0.1,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
        ),
        centerTitle: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              // color: Colors.indigo[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank Details',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        letterSpacing: 0.1,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Name'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: name,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Account Name",
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
                  height: 15,
                ),
                Text('Account Number'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: account,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Account number",
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
                  height: 15,
                ),
                Text('IFSC Code'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ifcs,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "IFSC code",
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
                  height: 15,
                ),
                Text('Address'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: address,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Address",
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
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                MaterialButton(
                  height: 48,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onPressed: () {
                    Navigation.instance.goBack();
                  },
                  child: const Text(
                    "BACK",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  color: Constants.secondaryColor,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Button(
                    onPressed: () async {
                      if (name.text.isNotEmpty &&
                          account.text.isNotEmpty &&
                          ifcs.text.isNotEmpty &&
                          address.text.isNotEmpty) {
                        await deactivatehelp(widget.reason, name.text,
                            account.text, ifcs.text, address.text);
                        // if (request.status ?? false) {
                        //   Fluttertoast.showToast(msg: request.message ?? "");
                        // }

                      } else {
                        Fluttertoast.showToast(msg: 'Fill all the details');
                      }
                    },
                    text: "DEACTIVATE ACCOUNT",
                  ),
                ),
              ],
            ),
          ),
        )
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        //     child: Button(
        //       onPressed: () {
        //         if (name.text.isNotEmpty &&
        //             account.text.isNotEmpty &&
        //             ifcs.text.isNotEmpty &&
        //             address.text.isNotEmpty) {
        //           requestDeactivate();
        //         } else {
        //           Fluttertoast.showToast(msg: 'Fill all the details');
        //         }
        //       },
        //       text: "Deactivate",
        //     ),
        //   ),
        // )
      ]),
    );
  }

  deactivatehelp(reason, accountname, accountnumber, ifsccode, address) async {
    final response = await ApiProvider.instance
        .deactivate(reason, accountname, accountnumber, ifsccode, address);
    if (response.status ?? false) {
      print('ebebe${response.message}');
      Fluttertoast.showToast(msg: response.message ?? "Successfull");
      Navigation.instance.navigateAndRemoveUntil('/main');
      // fetchLeads();
      // fetchPurchaseLeads();
      // fetchQuot();
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
}
