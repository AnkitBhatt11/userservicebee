import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'navigation/navigation.dart';


extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}


class Helpers{

  void datePicker(DateTime? selectedDate, Function(DateTime?) onDateChanged) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    BuildContext? context = Navigation.instance.navigatorKey.currentContext;
    if (context != null) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: Stack(
                  children: [
                    CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(fontSize: 15, fontFamily: "Montserrat",color: Colors.black)
                        ),
                      ),
                      child: CupertinoDatePicker(
                        initialDateTime: selectedDate ?? DateTime(2001, 11, 5),
                        onDateTimeChanged: onDateChanged,
                        maximumYear: DateTime.now().year - 18,
                        maximumDate: DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigation.instance.goBack();
                        },
                        child: Text("Done"),
                      ),
                    )
                  ],
                ));
          }
      );
    }
  }


  void showPhotoBottomSheet(Function(int) getImage){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    BuildContext? context = Navigation.instance.navigatorKey.currentContext;
    if(context != null){
      showDialog(
          barrierDismissible: true,
          context: context,
          builder:(BuildContext context){
            return AlertDialog(
                title: Center(child: Text("Add Photo", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)),
                contentPadding: EdgeInsets.only(top: 24, bottom: 30),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigation.instance.goBack();
                              getImage(0);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.pink.shade300
                                  ),
                                  child: Icon(Icons.camera_alt_rounded, color: Colors.white,),
                                ),
                                Text("Camera",style: TextStyle(fontSize: 14,)),
                              ],
                            )
                        ),
                        // SizedBox(width: 42,),
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
                        //               color: Colors.purple.shade300
                        //           ),
                        //           child: Icon(EvaIcons.image, color: Colors.white,),
                        //         ),
                        //         Text("Gallery",style: TextStyle(fontSize: 14,)),
                        //       ],
                        //     )
                        // ),
                      ],
                    ),
                  ],
                )
            );
          }
      );
    }
  }

  static Future<bool> isNetwork() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

}