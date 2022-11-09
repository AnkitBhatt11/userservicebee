import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/navigation/navigation.dart';

import '../../models/category_item.dart';
import '../../models/profile_item.dart';

class PincodePage extends StatefulWidget {
  @override
  State<PincodePage> createState() => _PincodePageState();
}

class _PincodePageState extends State<PincodePage> {
  List<CategoryItem> items = [
    // CategoryItem(title: "Window AC Service", subtitle: "", image: "assets/images/washing-machine.png"),
    // CategoryItem(title: "Split AC Installation", subtitle: "", image: "assets/images/electronics.png"),
    // CategoryItem(title: "L3 Service", subtitle: "", image: "assets/images/plumber.png"),
  ];
  List<String> pincodes = [
    "642103",
    "642001"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16,top: 20,bottom: 4),
                    child: Text("Your Services",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                  ),
                  ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, pos){
                      CategoryItem item = items[pos];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.blue.shade50
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(item.image!,height: 20,width: 20,),
                                  ),
                                  const SizedBox(width: 16,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.name!,style: const TextStyle(fontSize: 14.5,fontWeight: FontWeight.w500),),
                                        const SizedBox(height: 4,),
                                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry",style: TextStyle(fontSize: 12.5,color: Colors.grey.shade600,height: 1.6),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16,bottom: 4),
                    child: Text("Pincode",style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    decoration: BoxDecoration(
                      color: Constants.secondaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 0,
                      children: List.generate(pincodes.length + 1, (pos) => (pos == pincodes.length) ? MaterialButton(
                        onPressed: () async{
                          final result = await Navigation.instance.navigate("/addPincode");
                          if(result != null){
                            pincodes.add(result);
                            setState(() {});
                          }
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        elevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        height: 30,
                        child: const Text("Add New",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
                      ) : Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          ),
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(pincodes[pos],style: const TextStyle(fontSize: 14.5,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 6,),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: (){
                                    pincodes.removeAt(pos);
                                    setState(() {});
                                  },
                                  child: Icon(Icons.close_rounded,size: 14,color: Colors.grey.shade800,),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      ),
                    ),
                  ),
                  const SizedBox(height: 60,),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
                child: Row(
                  children: [
                    MaterialButton(
                      height: 48,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                      ),
                      onPressed: (){
                        Navigation.instance.goBack();
                      },
                      child: const Text("BACK",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,fontSize: 14),),
                      color: Constants.secondaryColor,
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Button(
                        onPressed: (){
                          Navigation.instance.navigate("/documentPick");
                        },
                        text: "Proceed",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

