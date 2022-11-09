import 'package:flutter/material.dart';
import '../constants.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          color: Constants.primaryColor,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
