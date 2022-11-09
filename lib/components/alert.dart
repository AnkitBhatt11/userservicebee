import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../navigation/navigation.dart';

class AlertX {
  AlertX._privateConstructor();
  static final AlertX instance = AlertX._privateConstructor();

  showAlert({required String title, required String msg, String? negativeButtonText, required String positiveButtonText,void Function()? negativeButtonPressed,required void Function() positiveButtonPressed}){
    var context = Navigation.instance.navigatorKey.currentContext;
    if(context!=null){
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
      showDialog(
          barrierDismissible: false,
          context: context,
          builder:(BuildContext context){
            return AlertDialog(
              title: Text(title, style:const TextStyle(fontWeight: FontWeight.w600),),
              contentPadding: const EdgeInsets.only(left: 24,right: 24,top: 8),
              actionsPadding: const EdgeInsets.only(left: 16,right: 16),
              content: Text(msg,style: const TextStyle(height: 1.5,fontSize: 14),),
              actions: [
                if(negativeButtonText!=null) TextButton(
                  onPressed: negativeButtonPressed,
                  child: Text(negativeButtonText,style: TextStyle(color: Colors.grey.shade500),),
                ),
                TextButton(
                  onPressed: positiveButtonPressed,
                  child: Text(positiveButtonText,style: const TextStyle(color: Colors.blue),),
                ),
              ],
            );
          }
      );
    }
  }

}
