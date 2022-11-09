import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/button.dart';
import '../../../constants.dart';
import '../../../navigation/navigation.dart';

class AddWithinCity extends StatefulWidget {
  AddWithinCity({Key? key}) : super(key: key){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ));
  }
  @override
  State<AddWithinCity> createState() => _AddWithinCityState();
}

class _AddWithinCityState extends State<AddWithinCity> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: Navigation.instance.goBack,
                child: Container()
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
            ),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 24,horizontal: 36),
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
            child: Column(
              children: [
                Text("Add City",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Constants.primaryColor),),
                const SizedBox(height: 20,),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.name,
                  maxLength: 6,
                  style: const TextStyle(color: Colors.black,fontFamily: "Montserrat"),
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter city",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.grey,fontFamily: "Montserrat"),
                      enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade100)
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade100)
                      ),
                      contentPadding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 16)
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 42,
                  child: Button(
                      text: "Proceed",
                      onPressed: (){
                        Navigator.pop(context,controller.text);
                      }
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: Navigation.instance.goBack,
                child: Container()
            ),
          )
        ],
      ),
    );
  }
}
