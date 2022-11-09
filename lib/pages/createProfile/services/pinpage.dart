// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:service_bee/components/button.dart';
// import 'package:service_bee/constants.dart';
// import 'package:service_bee/models/city_to_city.dart';
// import 'package:service_bee/models/pin_within_model.dart';
// import 'package:service_bee/models/service_item.dart';
// import 'package:service_bee/navigation/navigation.dart';
// import 'package:service_bee/pages/createProfile/city_pick_edit.dart';
// import 'package:service_bee/pages/createProfile/city_pick_page.dart';
// import 'package:service_bee/pages/network/searchpage.dart';
// import 'package:service_bee/storage/storage.dart';

// class pinpage extends StatefulWidget {
//   const pinpage({Key? key}) : super(key: key);

//   @override
//   State<pinpage> createState() => _pinpageState();
// }

// class _pinpageState extends State<pinpage> {
//   @override
//   List<City2Model> cities = [
//     // CategoryItem(name: "Chennai", desc: "Mumbai", image: ""),
//     // CategoryItem(name: "Mumbai", desc: "Kochi", image: ""),
//   ];
//   TextEditingController fromController = TextEditingController();
//   TextEditingController toController = TextEditingController();
//   // late ServiceCubit serviceCubit;
//   List<PinWithinModel> withinCity = [];
//   List<PinWithinModel> pincodes = [];
//   List<Map<String, Object>> maps = [];

//   String city = '';
//   String tocity = ' ';
//   List pins = [];

//   void initState() {
//     super.initState();

//     for (var i in Storage.instance.selected) {
//       Map<String, Object> map = {
//         "service_id": i.id ?? 0,
//         "type": i.type ?? 0,
//       };
//       maps.add(map);
//       if (i.type == 0) {
//         List<String> list = [];

//         withinCity.add(PinWithinModel(i.id, list));
//       } else if (i.type == 1) {
//         List<String> list = [];

//         pincodes.add(PinWithinModel(i.id, list));
//       } else {
//         List<CityToCity> list = [];
//         cities.add(City2Model(i.id, list));
//       }
//     }
//   }

//   Widget build(BuildContext context) {
//     ServiceItem item = Storage.instance.selected[0];
//     return Scaffold(
//       body: Stack(children: [
//         Center(
//           child: ExpansionTile(
//             title: Text('rbrb'),
//             children: getForm(item.type, 0, item.id!),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
//             child: Row(
//               children: [
//                 MaterialButton(
//                   height: 48,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4)),
//                   onPressed: () {
//                     Navigation.instance.goBack();
//                   },
//                   child: const Text(
//                     "BACK",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14),
//                   ),
//                   color: Constants.secondaryColor,
//                 ),
//                 const SizedBox(
//                   width: 16,
//                 ),
//                 Expanded(
//                   child: Button(
//                     onPressed: () async {
//                       // Storage.instance.selected
//                       //     .addAll(getSelectedItems());
//                       //   getForm(1, 0, 0);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CityPickPage(pins: pins)));
//                    //   Navigation.instance.navigate("/cityPick");
//                     },
//                     text: "Proceed",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ]),
//     );
//   }

//   getForm(int? type, int index, int id) {
//     switch (type) {
//       case 0:
//         return [
//           const Padding(
//             padding: EdgeInsets.only(left: 16, bottom: 4),
//             child: Text(
//               "Enter City",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Constants.secondaryColor,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Wrap(
//               spacing: 8,
//               runSpacing: 0,
//               children: List.generate(
//                   (getList(id).length ?? 0) + 1,
//                   (pos) => (pos == getList(id).length)
//                       ? MaterialButton(
//                           onPressed: () async {
//                             final result = await Navigation.instance
//                                 .navigate("/addPincode");
//                             if (result != null) {
//                               // getList(id).add(result);
//                               maps[index].update("cities",
//                                   (value) => getString(getList(id), result),
//                                   ifAbsent: () =>
//                                       getString(getList(id), result));
//                               setState(() {});
//                             }
//                           },
//                           color: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           elevation: 0,
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           height: 30,
//                           child: const Text(
//                             "Add New",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12),
//                           ),
//                         )
//                       : Card(
//                           margin: const EdgeInsets.only(bottom: 12),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(4)),
//                             margin: EdgeInsets.zero,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 6),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     getList(id)[pos],
//                                     style: const TextStyle(
//                                         fontSize: 14.5,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   const SizedBox(
//                                     width: 6,
//                                   ),
//                                   GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onTap: () {
//                                       // getList(id).removeAt(pos);
//                                       maps[index].update(
//                                           "cities",
//                                           (value) => removeString(
//                                               value.toString(), getList(id)));
//                                       setState(() {});
//                                     },
//                                     child: Icon(
//                                       Icons.close_rounded,
//                                       size: 14,
//                                       color: Colors.grey.shade800,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//             ),
//           ),
//         ];
//       case 1:
//         return [
//           const Padding(
//             padding: EdgeInsets.only(left: 16, bottom: 4),
//             child: Text(
//               "Enter Pincode",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color: Constants.secondaryColor,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Wrap(
//               spacing: 8,
//               runSpacing: 0,
//               children: List.generate(
//                   getPinList(id).length + 1,
//                   (pos) => (pos == getPinList(id).length)
//                       ? MaterialButton(
//                           onPressed: () async {
//                             final result = await Navigation.instance
//                                 .navigate("/addPincode");
//                             // withinCity.add(PinWithinModel(
//                             //     id, getString(getPinList(id), result)));
//                             if (result != null) {
//                               //   print('789789${ getString(getPinList(id), result)}');
//                               maps[index].update("pincodes",
//                                   (value) => getString(getPinList(id), result),
//                                   ifAbsent: () =>
//                                       getString(getPinList(id), result));
//                               setState(() {
//                                 // withinCity.add(PinWithinModel(
//                                 //     id, getString(getPinList(id), result)));
//                                 //     Navigation.instance
//                                 // .navigate("/cityPick");
//                               });
//                             }
//                           },
//                           color: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           elevation: 0,
//                           materialTapTargetSize:
//                               MaterialTapTargetSize.shrinkWrap,
//                           height: 30,
//                           child: const Text(
//                             "Add New",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12),
//                           ),
//                         )
//                       : Card(
//                           margin: const EdgeInsets.only(bottom: 12),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(4)),
//                             margin: EdgeInsets.zero,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 6),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     getPinList(id)[pos],
//                                     style: const TextStyle(
//                                         fontSize: 14.5,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   const SizedBox(
//                                     width: 6,
//                                   ),
//                                   GestureDetector(
//                                     behavior: HitTestBehavior.opaque,
//                                     onTap: () {
//                                       // getPinList(id).removeAt(pos);
//                                       maps[index].update(
//                                           "pincodes",
//                                           (value) => removeString(
//                                               pos, getPinList(id)));
//                                       setState(() {});
//                                     },
//                                     child: Icon(
//                                       Icons.close_rounded,
//                                       size: 14,
//                                       color: Colors.grey.shade800,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )),
//             ),
//           ),
//         ];
//       default:
//         return [
//           const Padding(
//             padding: EdgeInsets.only(left: 16, bottom: 4),
//             child: Text(
//               "Enter City",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             padding: EdgeInsets.zero,
//             itemCount: getCities(id).length,
//             shrinkWrap: true,
//             itemBuilder: (context, pos) {
//               return Container(
//                 height: 36,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 margin: const EdgeInsets.only(bottom: 8),
//                 child: Row(
//                   children: [
//                     // GestureDetector(
//                     //   onTap: () async {
//                     //     final result = await Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //         builder: (BuildContext context) => SearchPage(),
//                     //       ),
//                     //     );
//                     //     print('result ${result}');
//                     //     if (result != null) {
//                     //       (() {
//                     //         setState(() {
//                     //           city = result.toString();
//                     //         });
//                     //       });
//                     //     }
//                     //   },
//                     //   child: Container(
//                     //     height: 50,
//                     //     width: double.infinity,
//                     //     padding: EdgeInsets.all(3),
//                     //     decoration: BoxDecoration(
//                     //       color: Colors.red,
//                     //       border: Border.all(
//                     //         color: Colors.grey.shade500,
//                     //       ),
//                     //       borderRadius: BorderRadius.all(
//                     //         Radius.circular(5),
//                     //       ),
//                     //     ),
//                     //     child: Row(
//                     //       children: [
//                     //         Text(city),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                           margin: EdgeInsets.zero,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 8),
//                           decoration: BoxDecoration(
//                               //  color: Colors.red,
//                               borderRadius: BorderRadius.circular(4),
//                               border: Border.all(color: Colors.grey.shade300)),
//                           child: Text(
//                             getCities(id)[pos]!.city1,
//                             maxLines: 1,
//                           )),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       "TO",
//                       style:
//                           TextStyle(color: Colors.grey.shade800, fontSize: 14),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                           margin: EdgeInsets.zero,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 8),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               border: Border.all(color: Colors.grey.shade300)),
//                           child: Text(
//                             getCities(id)[pos]!.city2,
//                             maxLines: 1,
//                           )),
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         maps[index].update("city_to_city",
//                             (value) => removeCity(getCities(id), pos, id));
//                         setState(() {});
//                       },
//                       child: Container(
//                         height: 28,
//                         width: 40,
//                         decoration: BoxDecoration(
//                             color: Constants.secondaryColor,
//                             borderRadius: BorderRadius.circular(4)),
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: const Icon(
//                           Icons.minimize_rounded,
//                           color: Colors.black,
//                           size: 16,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//           const SizedBox(
//             height: 6,
//           ),
//           Container(
//             height: 32,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: StatefulBuilder(builder: (context, _) {
//                     return GestureDetector(
//                       onTap: () async {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (BuildContext context) => SearchPage(),
//                           ),
//                         );
//                         print('result ${result}');
//                         if (result != null) {
//                           _(() {
//                             setState(() {
//                               city = result.toString();
//                             });
//                           });
//                         }
//                       },
//                       child: Container(
//                         height: 50,
//                         width: double.infinity,
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           color: Color(0xffFAFAFA),
//                           border: Border.all(
//                             color: Colors.grey.shade500,
//                           ),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(5),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Text(city),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//                 // Expanded(
//                 //   flex: 1,
//                 //   child: Card(
//                 //       margin: EdgeInsets.zero,
//                 //       child: TextField(
//                 //         controller: fromController,
//                 //         decoration: const InputDecoration(
//                 //             border: InputBorder.none,
//                 //             contentPadding:
//                 //                 EdgeInsets.only(left: 8, right: 8, bottom: 12)),
//                 //       )),
//                 // ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Text(
//                   "TO",
//                   style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: StatefulBuilder(builder: (context, _) {
//                     return GestureDetector(
//                       onTap: () async {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (BuildContext context) => SearchPage(),
//                           ),
//                         );
//                         print('result ${result}');
//                         if (result != null) {
//                           _(() {
//                             setState(() {
//                               tocity = result.toString();
//                             });
//                           });
//                         }
//                       },
//                       child: Container(
//                         height: 50,
//                         width: double.infinity,
//                         padding: EdgeInsets.all(3),
//                         decoration: BoxDecoration(
//                           color: Color(0xffFAFAFA),
//                           border: Border.all(
//                             color: Colors.grey.shade500,
//                           ),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(5),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Text(tocity),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//                 // Expanded(
//                 //   flex: 1,
//                 //   child: Card(
//                 //       margin: EdgeInsets.zero,
//                 //       child: TextField(
//                 //         controller: toController,
//                 //         decoration: const InputDecoration(
//                 //             border: InputBorder.none,
//                 //             contentPadding:
//                 //                 EdgeInsets.only(left: 8, right: 8, bottom: 12)),
//                 //       )),
//                 // ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     setState(() {
//                       getCities(id).add(CityToCity(
//                           city1: city,
//                           //city1: fromController.text,
//                           // city2: toController.text));
//                           city2: tocity));
//                       maps[index].update(
//                           "city_to_city", (value) => getCityList(getCities(id)),
//                           ifAbsent: () => getCityList(getCities(id)));
//                       city = '';
//                       tocity = '';
//                       // fromController.clear();
//                       // toController.clear();
//                     });
//                   },
//                   child: Container(
//                     height: 28,
//                     width: 40,
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(4)),
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 80,
//           ),
//         ];
//     }
//   }

//   List getList(int id) {
//     for (var i in withinCity) {
//       if (i.id == id) {
//         return i.list ?? [];
//       }
//     }
//     return [];
//   }

//   List getPinList(int id) {
//     for (var i in pincodes) {
//       if (i.id == id) {
//         return i.list ?? [];
//       }
//     }
//     return List<String>.empty();
//   }

//   List<CityToCity?> getCities(int id) {
//     for (var i in cities) {
//       if (i.id == id) {
//         return i.list ?? [];
//       }
//     }
//     return List<CityToCity>.empty();
//   }

//   void createJSON() {
//     print(maps.toString());
//   }

//   getString(List list, val) {
//     var string = '';
//     print('val ${list} ${val}');
//     list.add(val);
//     pins = list;
//     return list;
//   }

//   removeString(pos, List list) {
//     print('removed at ${pos} ${list.length}');
//     list.removeAt(pos);
//     return list;
//   }

//   getCityList(List<CityToCity?> cities) {
//     var list = [];
//     for (var i in cities) {
//       list.add({
//         "city_from": i!.city1,
//         "city_to": i.city2,
//       });
//     }
//     return list;
//   }

//   removeCity(List<CityToCity?> cities, int pos, int id) {
//     try {
//       cities.removeAt(pos);
//     } catch (e) {
//       print(e);
//     }
//     try {
//       getCities(id).removeAt(pos);
//     } catch (e) {
//       print(e);
//     }
//     return cities;
//   }
// }
