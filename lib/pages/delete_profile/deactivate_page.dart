import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/pages/delete_profile/final_delete_page.dart';

import '../../constants.dart';
import '../../models/category_item.dart';

class DeactivatePage extends StatefulWidget {
  const DeactivatePage({Key? key}) : super(key: key);

  @override
  State<DeactivatePage> createState() => _DeactivatePageState();
}

class _DeactivatePageState extends State<DeactivatePage> {
  int currentIndex = 0;
  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });

    //  emit(CategoryChangeIndex());
  }

  TextEditingController controller = TextEditingController();
  List<String> ui = [
    'Reason 1 for deactivating',
    'Reason 2 for deactivating',
    'Reason 3 for deactivating',
    'Reason 4 for deactivating',
    'I have privacy concerns',
    'Others :'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Deactivating Account",
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
          Column(
            children: [
              ListView.builder(
                  itemCount: ui.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, pos) {
                    //   CategoryItem item = categoryCubit.categories[pos];
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: GestureDetector(
                          onTap: () {
                            changeIndex(pos);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Constants.primaryColor,
                                            width: 1.2),
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(5),
                                    child: (currentIndex == pos)
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Constants.primaryColor,
                                                shape: BoxShape.circle),
                                          )
                                        : const SizedBox(),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ui[pos] ?? "",
                                          style: const TextStyle(
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  }),
              if (currentIndex == 5)
                Card(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 8, right: 8, bottom: 12)),
                    )),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Button(
                onPressed: () {
                  print(ui[currentIndex]);
                  if (currentIndex == 5 && controller.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'fill the details');
                  } else {
                    if (currentIndex == 5 && controller.text.isNotEmpty) {
                     // Fluttertoast.showToast(msg: 'fill the details');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FinalDeletePage(reason: controller.text)));
                    }else{
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FinalDeletePage(reason: ui[currentIndex])));
                    }
                  }
                },
                text: "Proceed",
              ),
            ),
          )
        ]));
  }
}
