import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_bee/storage/storage.dart';
import '../../../components/button.dart';
import '../../../constants.dart';
import '../../../navigation/navigation.dart';

class AddMoneyPage extends StatefulWidget {
  AddMoneyPage({Key? key}) : super(key: key) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  State<AddMoneyPage> createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  TextEditingController controller = TextEditingController();
  int amount = 0;

  void onAmountChanged(int val) {
    amount = amount + val;
    controller.text = amount.toString();
    setState(() {});
  }

  Widget amountWidget(int value, value1) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            onAmountChanged(value);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: Colors.grey.shade300)),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(
              "+ \u{20B9}$value",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          "Get \u{20B9}${value1}",
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

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
                child: Container()),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Text(
                  "Add money to wallet",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Constants.primaryColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Montserrat"),
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      amount = int.parse(val);
                    } else {
                      amount = 0;
                    }
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: "Enter amount",
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
                const SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "*",
                      style: TextStyle(
                          color: Colors.pink, fontSize: 12, height: 1.6),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        child: Text(
                      "Get 35% extra by adding more than\n\u{20B9}5000",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          height: 1.6),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 16,
                    children: Storage.instance.rechargeAmounts.map((e) {
                      return amountWidget(
                          e.recharge_amount ?? 0, e.get_amount ?? 0);
                    }).toList(),
                    // children:[
                    //   amountWidget(100),
                    //   amountWidget(200),
                    //   amountWidget(1000),
                    //   amountWidget(2000),
                    // ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 42,
                  child: Button(
                      isDisabled: amount < 100,
                      text: "Proceed",
                      onPressed: () {
                        Navigator.pop(context, controller.text);
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: Navigation.instance.goBack,
                child: Container()),
          )
        ],
      ),
    );
  }
}
