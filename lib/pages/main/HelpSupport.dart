import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_bee/components/alert.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/storage/storage.dart';

// import '../components/button.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  fetchProfile() async {
    final response = await ApiProvider.instance.fetchProfile();
    if (response.status ?? false) {
      //  response.profile[0]

      // print(da[0].pins);
      // Storage.instance.setProfile(response.profile![0]);
    } else {
      print("THIS ERROR ${response.status}");
    }
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
          "Help & Support",
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
                  'Please fill up the form',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        letterSpacing: 0.1,
                        fontSize: 16,
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
                  readOnly: true,
                  controller: name,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: Storage.instance.profile?.name,
                      fillColor: Colors.white,
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
                Text('Email'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: account,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: " Enter Email",
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
                Text('Phone'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                     readOnly: true,
                  controller: ifcs,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: Storage.instance.profile?.phone,
                      fillColor: Colors.white,
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
                Text('Message'),
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
                      hintText: "Message",
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
                    Navigator.pop(context);
                    //    Navigation.instance.goBack();
                  },
                  child: const Text(
                    "BACK",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  color: Colors.grey[200],
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Button(
                    onPressed: () async {
                      if (Storage.instance.profile!.name != null &&
                          account.text.isNotEmpty &&
                          Storage.instance.profile!.phone != null &&
                          address.text.isNotEmpty) {
                        print(Storage.instance.profile!.name);
                         print(Storage.instance.profile!.phone);
                          print(account.text);
                            print(address.text);
                        await sendHelp(
                            Storage.instance.profile!.name,
                            account.text,
                            Storage.instance.profile?.phone,
                            address.text);
                        Fluttertoast.showToast(
                            msg: "Form submitted successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pop(context);
                        //   requestDeactivate();
                      } else {
                        Fluttertoast.showToast(msg: 'Fill all the details');
                      }
                    },
                    text: "SUBMIT",
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

  sendHelp(var name, var email, var phone, var message) async {
    final response =
        await ApiProvider.instance.sendHelpSupport(name, email, phone, message);
    if (response.status ?? false) {
      Fluttertoast.showToast(msg: response.message ?? "Successfull");
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
