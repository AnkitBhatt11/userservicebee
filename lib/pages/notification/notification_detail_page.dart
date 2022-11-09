import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_bee/components/alert.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/storage/storage.dart';

class NotificationDetailPage extends StatefulWidget {
  const NotificationDetailPage({Key? key}) : super(key: key);

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  String starthour = '00';
  String startmin = '00';
  String endhour = '24';
  String endmin = '00';
  String starthours = '';
  String startmins = '';
  String endhours = '';
  String endmins = '';
  late String start;
  late String endtime;
  void fetchProfile() async {
    final response = await ApiProvider.instance.fetchProfile();
    if (response.status ?? false) {
      //  response.profile[0]
      print('112233${(Storage.instance.profile!.notification_start_time)}');
    } else {
      print("THIS ERROR ${response.status}");
    }
  }

  void initState() {
    super.initState();
    fetchProfile();
  }

  TimeOfDay time = TimeOfDay(hour: 10, minute: 30);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Notification Settings",
          style: Theme.of(context).textTheme.caption!.copyWith(
                letterSpacing: 0.1,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //       icon: Icon(Icons.settings, color: Colors.black),
        //       onPressed: () {}),
        // ],
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification Start Time',
                style: const TextStyle(
                    fontSize: 16.5, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (starthours != '' && startmins != '')
                      ? Container(
                          child: Text('${starthours}:${startmins}'),
                          // child: Text('${starthour}:${startmin}'),
                        )
                      : Container(
                          child: Text(Storage.instance.profile!
                                      .notification_start_time ==
                                  ''
                              ? '${starthour}:${startmin}'
                              : Storage.instance.profile!
                                      .notification_start_time ??
                                  ""),
                          // child: Text('${starthour}:${startmin}'),
                        ),
                  // Container(
                  //   child: Text(),
                  // ),
                  ElevatedButton(
                      onPressed: () async {
                        final result = await showTimePicker(
                          context: context,
                          initialTime: time,
                          builder: (context, childd) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: childd!,
                            );
                          },
                        );
                        setState(() {
                          starthours = result!.hour.toString();
                          startmins = result!.minute.toString();
                        });
                        // print(result!.hour);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      child: Text('Edit')),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Notification End Time',
                style: const TextStyle(
                    fontSize: 16.5, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (endhours != '' && endmins != '')
                      ? Container(
                          child: Text('${endhours}:${endmins}'),
                          // child: Text('${starthour}:${startmin}'),
                        )
                      : Container(
                          child: Text(
                              Storage.instance.profile?.notification_end_time ==
                                      ""
                                  ? '${endhour}:${endmin}'
                                  : Storage.instance.profile!
                                          .notification_end_time ??
                                      ""),
                          //  child: Text('${endhour}:${endmin}'),
                        ),
                  ElevatedButton(
                      onPressed: () async {
                        final result = await showTimePicker(
                          context: context,
                          initialTime: time,
                          builder: (context, childd) {
                            return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: true),
                              child: childd!,
                            );
                          },
                        );
                        setState(() {
                          endhours = result!.hour.toString();
                          endmins = result.minute.toString();
                        });
                        // print(result!.hour.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 0),
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      child: Text('Edit')),
                ],
              )
            ],
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
                      setState(() {
                        if (starthours == '') {
                          // start = Storage
                          //         .instance.profile?.notification_start_time ??
                          //     "00:00";
                          starthours = Storage.instance.profile
                                      ?.notification_start_time ==
                                  ''
                              ? '00'
                              : Storage
                                      .instance.profile?.notification_start_time
                                      .toString()
                                      .substring(0, 2) ??
                                  "00";
                          startmins = Storage.instance.profile
                                      ?.notification_start_time ==
                                  ''
                              ? '00'
                              : Storage
                                      .instance.profile?.notification_start_time
                                      .toString()
                                      .substring(3, 5) ??
                                  "00";
                          start = '${starthours}:${startmins}';
                        } else {
                          start = '${starthours}:${startmins}';
                        }
                        if (endhours == '') {
                          // endtime =
                          //     Storage.instance.profile?.notification_end_time ??
                          //         "00:00";
                       
                          endhours = Storage.instance.profile
                                      ?.notification_end_time ==
                                  ''
                              ? '24'
                              : Storage.instance.profile?.notification_end_time
                                      .toString()
                                      .substring(0, 2) ??
                                  "00";
                          endmins = Storage.instance.profile
                                      ?.notification_end_time ==
                                  ''
                              ? '00'
                              : Storage.instance.profile?.notification_end_time
                                      .toString()
                                      .substring(3, 5) ??
                                  "00";
                          endtime = '${endhours}:${endmins}';
                        } else {
                          endtime = '${endhours}:${endmins}';
                        }
                      });

                      if ((int.parse(starthours) > int.parse(endhours)) ||
                          ((int.parse(starthours) == int.parse(endhours)) &&
                              (int.parse(startmins) > int.parse(endmins)))) {
                        showError(
                            "Start time cannot be greater than End time ");
                      } else {
                        await notificationhelp(start, endtime);
                      }
                    },
                    text: "SUBMIT",
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  notificationhelp(start, endtime) async {
    final response =
        await ApiProvider.instance.notificationsetting(start, endtime);
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
