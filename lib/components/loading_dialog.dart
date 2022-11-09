import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class LoadingDialog extends StatelessWidget {
  LoadingDialog(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
              ),
              child: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Constants.primaryColor,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
