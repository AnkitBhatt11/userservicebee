import 'package:flutter/material.dart';
import '../constants.dart';

enum ButtonType{
  filled,
  outlined,
}

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;
  final ButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  Button({required this.text,required this.onPressed,this.color,this.type = ButtonType.filled, this.isLoading = false, this.icon,this.isDisabled = false});

  Widget loaderWidget(){
    return SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: (type == ButtonType.outlined) ? color ?? Constants.primaryColor : Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isDisabled ? null : (isLoading ? (){} : onPressed),
      child: (isLoading) ? loaderWidget() : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null)Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(icon, color: (type == ButtonType.outlined) ? (color ?? Constants.primaryColor) : Colors.white,size: 20,),
          ),
          const Spacer(),
          Text(text.toUpperCase(),style: TextStyle(color: isDisabled ? Colors.grey : ((type == ButtonType.outlined) ? (color ?? Constants.primaryColor) : Colors.white),fontWeight: FontWeight.bold,fontSize: 14),),
          const Spacer(),
        ],
      ),
      minWidth: double.infinity,
      height: 48,
      elevation: 0,
      disabledColor: Colors.grey.shade100,
      color: (type == ButtonType.filled) ? (color ?? Constants.primaryColor) : null,
      shape: (type == ButtonType.outlined) ? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: color ?? Constants.primaryColor,)
      ) : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }
}
