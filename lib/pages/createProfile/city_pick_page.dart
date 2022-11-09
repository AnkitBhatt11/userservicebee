import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/models/city_add_model.dart';
import 'package:service_bee/models/pin_within_model.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/pages/createProfile/services/service_bloc.dart';
import 'package:service_bee/pages/network/searchpage.dart';
import 'package:service_bee/storage/storage.dart';
import 'package:google_maps_webservice/places.dart';
import '../../models/category_item.dart';
import '../../models/city_to_city.dart';
import '../../models/profile_item.dart';
import '../../models/service_item.dart';
import 'add_pincode_page.dart';

class CityPickPage extends StatefulWidget {
  @override
  State<CityPickPage> createState() => _CityPickPageState();
}

class _CityPickPageState extends State<CityPickPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider<ServiceCubit>(
          create: (context) => ServiceCubit(),
          child: SafeArea(
            child: city_pick_body(),
          ),
        ),
      ),
    );
  }
}

class city_pick_body extends StatefulWidget {
  //const city_pick_body({Key? key}) : super(key: key);

  @override
  State<city_pick_body> createState() => _city_pick_bodyState();
}

class _city_pick_bodyState extends State<city_pick_body> {
  List<City2Model> cities = [
    // CategoryItem(name: "Chennai", desc: "Mumbai", image: ""),
    // CategoryItem(name: "Mumbai", desc: "Kochi", image: ""),
  ];
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  late ServiceCubit serviceCubit;
  List<PinWithinModel> withinCity = [];
  List<PinWithinModel> pincodes = [];
  List<String> list = [];
  List<String> list1 = [];
  List<CityToCity> city2ci = [];
  List<Map<String, Object>> maps = [];
  var res;

  String city = '';
  String tocity = ' ';

  bool cityCheck = false;
  late int cityid;
  late int city2cityid;
  late int pinid;
  bool city2cityCheck = false;
  bool pincodesCheck = false;
  check() {
    for (int i = 0; i < Storage.instance.selected.length; i++) {
      if (Storage.instance.selected[i].type == 0) {
        cityCheck = true;
        cityid = Storage.instance.selected[i].id ?? 0;
      } else if (Storage.instance.selected[i].type == 1) {
        pincodesCheck = true;
        pinid = Storage.instance.selected[i].id ?? 0;
      } else if (Storage.instance.selected[i].type == 2) {
        city2cityCheck = true;
        city2cityid = Storage.instance.selected[i].id ?? 0;
      }
    }
  }

  int fir = 0;
  int sec = 0;
  int zero = 0;
  int submit = 0;
  int ppage = -1;
  int wpage = -1;
  int cpage = -1;
  int page = 0;
  @override
  void initState() {
    super.initState();
    check();
    if (pincodesCheck && !cityCheck && !city2cityCheck) {
      submit = 0;
      ppage = 0;
    } else if (!pincodesCheck && cityCheck && !city2cityCheck) {
      submit = 0;
      wpage = 0;
    } else if (!pincodesCheck && !cityCheck && city2cityCheck) {
      submit = 0;
      cpage = 0;
    } else if (pincodesCheck && cityCheck && !city2cityCheck) {
      submit = 1;
      ppage = 1;
      wpage = 0;
    } else if (pincodesCheck && !cityCheck && city2cityCheck) {
      submit = 1;
      ppage = 1;
      cpage = 0;
    } else if (!pincodesCheck && cityCheck && city2cityCheck) {
      submit = 1;
      wpage = 0;
      cpage = 1;
    } else if (pincodesCheck && cityCheck && city2cityCheck) {
      submit = 2;
      wpage = 0;
      cpage = 1;
      ppage = 2;
    }

    if (submit == 0) {
      lastPage = true;
    }
    for (var i in Storage.instance.selected) {
      Map<String, Object> map = {
        "service_id": i.id ?? 0,
        "type": i.type ?? 0,
      };
      maps.add(map);
      if (i.type == 0) {
        //   List<String> list = [];

        withinCity.add(PinWithinModel(i.id, list1));
      } else if (i.type == 1) {
        //  List<String> list = [];
        //   pincodes.add(PinWithinModel(i.id, widget.pins));
        pincodes.add(PinWithinModel(i.id, list));
      } else {
        //  List<CityToCity> list = [];
        cities.add(City2Model(i.id, city2ci));
      }
    }

    for (var pos = 0; pos < Storage.instance.selected.length; pos++) {
      ServiceItem item = Storage.instance.selected[pos];
      if (item.type == 1) {
        maps[pos].update("pincodes", (value) => ups(getPinList(item.id!), list),
            ifAbsent: () => ups(getPinList(item.id!), list));
      } else if (item.type == 2) {
        print('tyuiop${getCities(item.id!)}');
        maps[pos].update("city_to_city",
            (value) => up(getCityList(getCities(item.id!)), city2ci),
            ifAbsent: () => getCityList(getCities(item.id!)));
      } else if (item.type == 0) {
        print('tyuiop${getCities(item.id!)}');
        maps[pos].update("cities", (value) => ups(getList(item.id!), list1),
            ifAbsent: () => ups(getList(item.id!), list1));
      }
    }
    print('maps : $maps');
    bool firs = false;
    bool secy = false;
    bool zeroy = false;
    for (var pos = 0; pos < Storage.instance.selected.length; pos++) {
      ServiceItem item = Storage.instance.selected[pos];
      if (item.type == 1 && firs == false) {
        fir = pos;

        print('fir$fir');
        firs = true;
      } else if (item.type == 2 && secy == false) {
        sec = pos;
        print('sec$sec');
        secy = true;
      } else if (item.type == 0 && zeroy == false) {
        zero = pos;
        print('zero$zero');
        zeroy = true;
      }
    }
  }

  bool plz = false;
  bool pl = false;
  final controller = PageController();
  bool lastPage = false;
  bool prevpage = false;
  @override
  Widget build(BuildContext context) {
    serviceCubit = BlocProvider.of<ServiceCubit>(context);
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 20, bottom: 4),
                child: Text(
                  "Add Services",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: MediaQuery.of(context).copyWith().size.height / 0.8,
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  // physics,
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      page = index;
                      lastPage = index == submit;
                      prevpage = index == 1 || index == 2;
                    });
                  },
                  children: [
                    //start
                    if (cityCheck)
                      // ExpansionTile(
                      //     title: Column(
                      //       children: getForm(0, 0, cityid),
                      //     ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                          //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: getForm(0, zero, cityid),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, bottom: 2),
                              child: Text(
                                "WithinCity Services",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            ListView.builder(
                              itemCount: Storage.instance.selected.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, pos) {
                                ServiceItem item =
                                    Storage.instance.selected[pos];
                                plz = true;
                                if (item.type == 0) {
                                  return Card(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          Colors.blue.shade50),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${Constants.imgBaseUrl}${item.image}",
                                                    height: 20,
                                                    width: 20,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, _) =>
                                                        const SizedBox(),
                                                    errorWidget:
                                                        (context, err, _) =>
                                                            const SizedBox(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item.name!,
                                                        style: const TextStyle(
                                                            fontSize: 14.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '',
                                                        // "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: Colors
                                                                .grey.shade600,
                                                            height: 1.6),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                      height: 0.000000000000000000000000001);
                                }
                              },
                            ),
                          ]),
                    // if (pincodesCheck)
                    //   Column(
                    //     children: getForm(1, 0, pinid),
                    //   ),
                    if (city2cityCheck)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: getForm(2, sec, city2cityid),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, bottom: 2),
                              child: Text(
                                "CityToCity Services",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            ListView.builder(
                              itemCount: Storage.instance.selected.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, pos) {
                                ServiceItem item =
                                    Storage.instance.selected[pos];
                                pl = true;
                                if (item.type == 2) {
                                  return Card(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          Colors.blue.shade50),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${Constants.imgBaseUrl}${item.image}",
                                                    height: 20,
                                                    width: 20,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, _) =>
                                                        const SizedBox(),
                                                    errorWidget:
                                                        (context, err, _) =>
                                                            const SizedBox(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item.name!,
                                                        style: const TextStyle(
                                                            fontSize: 14.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '',
                                                        // "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: Colors
                                                                .grey.shade600,
                                                            height: 1.6),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: 0.0000000001);
                                }
                              },
                            ),
                          ]),
                    if (pincodesCheck)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: getForm(1, fir, pinid),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16, bottom: 2),
                              child: Text(
                                "Pincodes Services",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            ListView.builder(
                              itemCount: Storage.instance.selected.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, pos) {
                                ServiceItem item =
                                    Storage.instance.selected[pos];
                                // maps[pos].update(
                                //     "pincodes", (value) => ups(getPinList(item.id!), widget.pins),
                                //     ifAbsent: () => ups(getPinList(item.id!), widget.pins));
                                if (item.type == 1) {
                                  return Card(
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          Colors.blue.shade50),
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${Constants.imgBaseUrl}${item.image}",
                                                    height: 20,
                                                    width: 20,
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, _) =>
                                                        const SizedBox(),
                                                    errorWidget:
                                                        (context, err, _) =>
                                                            const SizedBox(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item.name!,
                                                        style: const TextStyle(
                                                            fontSize: 14.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        '',
                                                        // "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                                                        style: TextStyle(
                                                            fontSize: 12.5,
                                                            color: Colors
                                                                .grey.shade600,
                                                            height: 1.6),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: 0.0000000001);
                                }
                              },
                            ),
                          ])

//end
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Row(
              children: [
                (prevpage)
                    ? MaterialButton(
                        height: 48,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        onPressed: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: const Text(
                          "BACK",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        color: Constants.secondaryColor,
                      )
                    : MaterialButton(
                        height: 48,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        onPressed: () {
                          Storage.instance.selected = [];
                          List<String> list = [];
                          List<String> list1 = [];
                          List<CityToCity> city2ci = [];
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
                  child: lastPage
                      ? Button(
                          onPressed: () {
                            Storage.instance.maps = maps;
                            print('ssbs${Storage.instance.selected[0].type}');

                            if (Storage.instance.selected[0].type == 0) {
                              if (list1.isEmpty) {
                                Fluttertoast.showToast(msg: 'Enter details');
                              } else {
                                Storage.instance.maps = maps;
                                Navigation.instance.navigate("/documentPick");
                                createJSON();
                              }
                            } else if (Storage.instance.selected[0].type == 1) {
                              if (list.isEmpty) {
                                print('5656${list}');
                                Fluttertoast.showToast(msg: 'Enter details');
                              } else {
                                Storage.instance.maps = maps;
                                Navigation.instance.navigate("/documentPick");
                                createJSON();
                              }
                            } else if (Storage.instance.selected[0].type == 2) {
                              if (city2ci.isEmpty) {
                                Fluttertoast.showToast(msg: 'Enter details');
                              } else {
                                Storage.instance.maps = maps;
                                Navigation.instance.navigate("/documentPick");
                                createJSON();
                              }
                            }
                          },
                          text: "Submit",
                        )
                      : Button(
                          onPressed: () {
                            Storage.instance.maps = maps;
                            if (submit == 0) {
                              if (Storage.instance.selected[zero].type == 0 &&
                                  cityCheck) {
                                if (list1.isEmpty) {
                                  print('5656${list1}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  plz = false;
                                  //    Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              } else if (Storage.instance.selected[fir].type ==
                                      1 &&
                                  pincodesCheck) {
                                if (list.isEmpty) {
                                  print('565600${list}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  // Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  // Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              } else if (Storage.instance.selected[sec].type ==
                                      2 &&
                                  city2cityCheck) {
                                print('retery${Storage.instance.selected}');
                                if (city2ci.isEmpty) {
                                  print('retery${city2ci.isEmpty}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  pl = false;
                                  // Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              }
                            } else if (submit == 1) {
                              if (Storage.instance.selected[zero].type == 0 &&
                                  cityCheck &&
                                  wpage != -1) {
                                if (list1.isEmpty) {
                                  print('5656${list1}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  plz = false;
                                  //    Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              } else if (Storage.instance.selected[sec].type ==
                                      2 &&
                                  city2cityCheck &&
                                  cpage != -1) {
                                print('retery${Storage.instance.selected}');
                                if (city2ci.isEmpty) {
                                  print('retery${city2ci.isEmpty}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  pl = false;
                                  // Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              } else if (Storage.instance.selected[fir].type ==
                                      1 &&
                                  pincodesCheck &&
                                  ppage != -1) {
                                if (list.isEmpty) {
                                  print('565600${list}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  // Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  // Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              }
                            } else if (submit == 2) {
                              if (Storage.instance.selected[zero].type == 0 &&
                                  cityCheck &&
                                  wpage == page) {
                                if (list1.isEmpty) {
                                  print('5656${list1}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  plz = false;
                                  //    Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              } else if (Storage.instance.selected[fir].type ==
                                      1 &&
                                  pincodesCheck &&
                                  ppage == page) {
                                if (list.isEmpty) {
                                  print('565600${list}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  // Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  // Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              } else if (Storage.instance.selected[sec].type ==
                                      2 &&
                                  city2cityCheck &&
                                  cpage == page) {
                                print('retery${Storage.instance.selected}');
                                if (city2ci.isEmpty) {
                                  print('retery${city2ci.isEmpty}');
                                  Fluttertoast.showToast(msg: 'Enter details');
                                } else {
                                  Storage.instance.maps = maps;
                                  controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                  pl = false;
                                  // Navigation.instance.navigate("/documentPick");
                                  createJSON();
                                }
                              }
                            }
                          },
                          text: "Proceed",
                        ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  getForm(int? type, int index, int id) {
    switch (type) {
      case 0:
        return [
          Align(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 20, bottom: 4),
              child: Text(
                "Enter City",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          Container(
            decoration: BoxDecoration(
              color: Constants.secondaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 0,
              children: List.generate(
                  (getList(id).length ) + 1,
                  (pos) => (pos == getList(id).length)
                      ? MaterialButton(
                          onPressed: () async {
                            final result = await _handlePressButton();
                            // final result = await Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (BuildContext context) => SearchPage(),
                            //   ),
                            // );
                            // setState(() {
                            //   print('565$res');
                            //   res = result;
                            // });

                            if (result != null) {
                              // getList(id).add(result);
                              maps[index].update("cities", (value) {
                                if (getList(id).contains(result)) {
                                  return Fluttertoast.showToast(
                                      msg: 'Already Added !');
                                } else {
                                  return getString(getList(id), result);
                                }
                              },
                                  ifAbsent: () =>
                                      getString(getList(id), result));
                              setState(() {});
                            }
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 0,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          height: 30,
                          child: const Text(
                            "Add New",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        )
                      : Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getList(id)[pos],
                                    style: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      // getList(id).removeAt(pos);
                                      maps[index].update(
                                          "cities",
                                          (value) =>
                                              removeString(pos, getList(id)));
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 14,
                                      color: Colors.grey.shade800,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
            ),
          ),
        ];
      case 1:
        return [
          Align(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 2),
              child: Text(
                "Enter Pincode",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          Container(
            decoration: BoxDecoration(
              color: Constants.secondaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 0,
              children: List.generate(
                  getPinList(id).length + 1,
                  (pos) => (pos == getPinList(id).length)
                      ? MaterialButton(
                          onPressed: () async {
                            final result = await Navigation.instance
                                .navigate("/addPincode");
                            if (result != null) {
                              print('789789${getPinList(id)}');
                              maps[index].update("pincodes", (value) {
                                if (getPinList(id).contains(result)) {
                                  return Fluttertoast.showToast(
                                      msg: 'Already added !');
                                } else {
                                  return getString(getPinList(id), result);
                                }
                              },
                                  ifAbsent: () =>
                                      getString(getPinList(id), result));
                              setState(() {
                                // withinCity.add(PinWithinModel(
                                //     id, getString(getPinList(id), result)));
                                //     Navigation.instance
                                // .navigate("/cityPick");
                              });
                            }
                          },
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          elevation: 0,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          height: 30,
                          child: const Text(
                            "Add New",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        )
                      : Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    getPinList(id)[pos],
                                    style: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      // getPinList(id).removeAt(pos);
                                      maps[index].update(
                                          "pincodes",
                                          (value) => removeString(
                                              pos, getPinList(id)));
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.close_rounded,
                                      size: 14,
                                      color: Colors.grey.shade800,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
            ),
          ),
        ];
      default:
        return [
          Align(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 4),
              child: Text(
                "Enter City",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: getCities(id).length,
            shrinkWrap: true,
            itemBuilder: (context, pos) {
              return Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    // GestureDetector(
                    //   onTap: () async {
                    //     final result = await Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (BuildContext context) => SearchPage(),
                    //       ),
                    //     );
                    //     print('result ${result}');
                    //     if (result != null) {
                    //       (() {
                    //         setState(() {
                    //           city = result.toString();
                    //         });
                    //       });
                    //     }
                    //   },
                    //   child: Container(
                    //     height: 50,
                    //     width: double.infinity,
                    //     padding: EdgeInsets.all(3),
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       border: Border.all(
                    //         color: Colors.grey.shade500,
                    //       ),
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(5),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Text(city),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                              //  color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Text(
                            getCities(id)[pos]!.city1,
                            maxLines: 1,
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "TO",
                      style:
                          TextStyle(color: Colors.grey.shade800, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.zero,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Text(
                            getCities(id)[pos]!.city2,
                            maxLines: 1,
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        maps[index].update("city_to_city",
                            (value) => removeCity(getCities(id), pos, id));
                        setState(() {
                          for (var pos = 0;
                              pos < Storage.instance.selected.length;
                              pos++) {
                            ServiceItem item = Storage.instance.selected[pos];
                            if (item.type == 1) {
                              maps[pos].update("pincodes",
                                  (value) => ups(getPinList(item.id!), list),
                                  ifAbsent: () =>
                                      ups(getPinList(item.id!), list));
                            }
                            //  else if (item.type == 2) {
                            //   print('tyuiop${getCities(item.id!)}');
                            //   maps[pos].update("city_to_city",
                            //       (value) => getCityList(getCities(id)),
                            //       ifAbsent: () => getCityList(getCities(id)));
                            // }
                          }
                        });
                      },
                      child: Container(
                        height: 28,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Constants.secondaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.only(bottom: 8),
                        child: const Icon(
                          Icons.minimize_rounded,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: StatefulBuilder(builder: (context, _) {
                    return GestureDetector(
                      onTap: () async {
                        final result = await _handlePressButton();
                        print('result ${result}');
                        if (result != null) {
                          _(() {
                            setState(() {
                              city = result.toString();
                            });
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color(0xffFAFAFA),
                          border: Border.all(
                            color: Colors.grey.shade500,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(city),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Card(
                //       margin: EdgeInsets.zero,
                //       child: TextField(
                //         controller: fromController,
                //         decoration: const InputDecoration(
                //             border: InputBorder.none,
                //             contentPadding:
                //                 EdgeInsets.only(left: 8, right: 8, bottom: 12)),
                //       )),
                // ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "TO",
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: StatefulBuilder(builder: (context, _) {
                    return GestureDetector(
                      onTap: () async {
                        final result = await _handlePressButton();
                        print('result ${result}');
                        if (result != null) {
                          _(() {
                            setState(() {
                              tocity = result.toString();
                              bool copied = false;

                              // getCities(id).add(CityToCity(
                              //     city1: city,
                              //     //city1: fromController.text,
                              //     // city2: toController.text));
                              //     city2: tocity));
                              //  print(getCityList(getCities(id)).);

                              print(getCityList(getCities(id)).map((e) {
                                if (e["city_from"] == city &&
                                    e["city_to"] == tocity) {
                                  copied = true;
                                }
                              }));
                              print('copied : $copied');
                              print(maps[index]);
                              maps[index].update("city_to_city", (value) {
                                if (copied == true) {
                                  copied = false;
                                  return Fluttertoast.showToast(
                                      msg: 'Already Added !');
                                } else {
                                  print('err');
                                  getCities(id).add(
                                      CityToCity(city1: city, city2: tocity));
                                  return getCityList(getCities(id));
                                }
                              });
                              city = '';
                              tocity = '';
                              // print(
                              //     '156${getCityList(getCities(id)).elementAt(0)}');
                              setState(() {
                                for (var pos = 0;
                                    pos < Storage.instance.selected.length;
                                    pos++) {
                                  ServiceItem item =
                                      Storage.instance.selected[pos];
                                  if (item.type == 1) {
                                    maps[pos].update(
                                        "pincodes",
                                        (value) =>
                                            ups(getPinList(item.id!), list),
                                        ifAbsent: () =>
                                            ups(getPinList(item.id!), list));
                                  } else if (item.type == 2) {
                                    print('tyuiop${getCities(item.id!)}');
                                    maps[pos].update("city_to_city",
                                        (value) => getCityList(getCities(id)),
                                        ifAbsent: () =>
                                            getCityList(getCities(id)));
                                  }
                                }
                              });
                            });
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Color(0xffFAFAFA),
                          border: Border.all(
                            color: Colors.grey.shade500,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(tocity),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Card(
                //       margin: EdgeInsets.zero,
                //       child: TextField(
                //         controller: toController,
                //         decoration: const InputDecoration(
                //             border: InputBorder.none,
                //             contentPadding:
                //                 EdgeInsets.only(left: 8, right: 8, bottom: 12)),
                //       )),
                // ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      // getCities(id).add(CityToCity(
                      //     city1: city,
                      //     //city1: fromController.text,
                      //     // city2: toController.text));
                      //     city2: tocity));
                      // maps[index].update(
                      //     "city_to_city", (value) => getCityList(getCities(id)),
                      //     ifAbsent: () => getCityList(getCities(id)));
                      // print('1566${getCityList(getCities(id))}');
                      city = '';
                      tocity = '';
                      // fromController.clear();
                      // toController.clear();
                    });
                  },
                  child: Container(
                    height: 28,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ];
    }
  }

  List getList(int id) {
    for (var i in withinCity) {
      if (i.id == id) {
        return i.list ?? [];
      }
    }
    return [];
  }

  List getPinList(int id) {
    for (var i in pincodes) {
      if (i.id == id) {
        return i.list ?? [];
      }
    }
    return List<String>.empty();
  }

  List<CityToCity?> getCities(int id) {
    for (var i in cities) {
      if (i.id == id) {
        return i.list ?? [];
      }
    }
    return List<CityToCity>.empty();
  }

  List<CityToCity?> up(List<CityToCity?> val, List<CityToCity?> lisy) {
    val = lisy;
    return val;
  }

  void createJSON() {
    print('bwb');
    print(maps.toString());
  }

  getString(List list, val) {
    var string = '';
    print('val ${list} ${val}');
    list.add(val);
    return list;
  }

  ups(List list, List val) {
    list = val;
    return list;
  }

  removeString(pos, List list) {
      print('removed at ${pos} ${list.length}');
    list.removeAt(pos);
    return list;
  }

  getCityList(List<CityToCity?> cities) {
    List<Map<String, String>> list = [];
    for (var i in cities) {
      list.add({
        "city_from": i!.city1,
        "city_to": i.city2,
      });
      // list.add(CityToCity(city1: i!.city1, city2: i.city2));
    }
    // print('vsvsv${cities.first}');

    // print('0987654321$list');
    return list;
  }

  removeCity(List<CityToCity?> cities, int pos, int id) {
    try {
      cities.removeAt(pos);
    } catch (e) {
      print(e);
    }
    try {
      getCities(id).removeAt(pos);
    } catch (e) {
      print(e);
    }
    return cities;
  }

  _handlePressButton() async {
    try {
//final center = await getUserLocation();
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        strictbounds: false,
        apiKey: "AIzaSyC-29KZIc0M_3Yw3LQXDjx3dg7ifMRUyhg",
        components: [Component(Component.country, "in")],
//onError: onError,
        mode: Mode.overlay,
        language: "en",
        types: ["(cities)"] ?? [],
      );
// location: center == null
// ? null
// : Location(center.latitude, center.longitude),
// radius: center == null ? null : 10000);

//showDetailPlace(p.placeId);
      return p?.description?.split(',')[0];
    } catch (e) {
      return;
    }
  }
}
