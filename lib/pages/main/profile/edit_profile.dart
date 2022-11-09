import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:service_bee/storage/storage.dart';

import '../../../components/alert.dart';
import '../../../components/button.dart';
import '../../../constants.dart';
import '../../../models/service_item.dart';
import '../../../navigation/navigation.dart';
import '../../../network/api_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _name = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  File? selfie;
  File? aadharFront;
  File? aadharBack;
  File? idFront;
  File? idBack;
  String selectedId = "Voter Id";
  List<String> ids = ["Voter Id", "Driving License"];

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
  }

  // scroll() {
  //   if (listScrollController.offset ==
  //       listScrollController.position.maxScrollExtent) {
  //     setState(() {
  //       down == true;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          /* only set when the previous state is false
             * Less widget rebuilds 
             */
          print("**** ${_isVisible} up"); //Move IO away from setState
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            /* only set when the previous state is false
               * Less widget rebuilds 
               */
            print("**** ${_isVisible} down"); //Move IO away from setState
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
    fetchProfile();
    // listScrollController.addListener(scroll());
    Future.delayed(Duration(seconds: 2), () {
      _name.text = Storage.instance.profile?.name ?? "";
      // print('opop${Storage.instance.profile?.name}');
    });
  }

  int _counter = 0;
  late ScrollController _hideButtonController;
  _incrementCounter() {
    setState(() {
      _isVisible = false;
    });

    _hideButtonController.animateTo(
      _hideButtonController.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  var _isVisible;
  fetchProfile() async {
    final response = await ApiProvider.instance.fetchProfile();
    if (response.status ?? false) {
      //  response.profile[0]
      print('112233${response}');
      print('rettt${Storage.instance.selected[0].city2city}');

      // print(da[0].pins);
      // Storage.instance.setProfile(response.profile![0]);
    } else {
      print("THIS ERROR ${response.status}");
    }
  }

  // ScrollController listScrollController = ScrollController();
  // bool down = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new Visibility(
        visible: _isVisible,
        child: new FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // focusColor: Colors.transparent,
          // foregroundColor: Colors.transparent,
          // hoverColor: Colors.transparent,
          // splashColor: Colors.transparent,
          onPressed: _incrementCounter,
          tooltip: 'Scroll down !',
          child: new Icon(
            Icons.arrow_downward,
            color: Colors.black,
          ),
        ),
      ),
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            "Edit Profile",
            style: TextStyle(
                fontSize: 17.5,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: InkWell(
                onTap: () {
                  showMsg("Check Notification for Document Status");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Document Status",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          Storage.instance.profile?.document_status ?? "NA",
                          style: TextStyle(
                              fontSize: 14.5,
                              color: Storage
                                          .instance.profile?.document_status ==
                                      "pending"
                                  ? Colors.black45
                                  : Storage.instance.profile?.document_status ==
                                          "verified"
                                      ? Colors.green
                                      : Storage.instance.profile
                                                  ?.document_status ==
                                              "rejected"
                                          ? Colors.red
                                          : Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          controller: _hideButtonController,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showPhotoBottomSheet(getSelfieImage);
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: selfie == null
                            // ? Storage.instance.profile?.profile_picture == null
                            ? Image.network(
                                //'',
                                Storage.instance.profile?.profile_picture ?? '',

                                fit: BoxFit.fill,
                              )
                            // : Container(
                            //     color: Colors.grey[100],
                            //     child: Center(
                            //         child: Text('Add Profile Picture')))
                            : Image.file(
                                selfie!,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade900,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade800,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (Storage.instance.profile?.document_status ==
                              "rejected") {
                            showPhotoBottomSheet(getAadharFrontImage);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              margin: EdgeInsets.zero,
                              child: Container(
                                height: 150,
                                // width: 200,
                                alignment: Alignment.center,
                                child: aadharFront == null
                                    // ? Storage.instance.profile?.adhaar_front ==
                                    //         null
                                    ? Image.network(
                                        Storage.instance.profile
                                                ?.adhaar_front ??
                                            "",
                                        fit: BoxFit.fill,
                                      )
                                    // : Container(
                                    //     color: Colors.grey[100],
                                    //     child: Center(
                                    //         child:
                                    //             Text('Add Aadhar front')))
                                    : Image.file(
                                        aadharFront!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            if (Storage.instance.profile?.document_status ==
                                "rejected")
                              const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (Storage.instance.profile?.document_status ==
                              "rejected") {
                            showPhotoBottomSheet(getAadharBackImage);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              margin: EdgeInsets.zero,
                              child: Container(
                                height: 150,
                                // width: 200,
                                alignment: Alignment.center,
                                child: aadharBack == null
                                    // ? Storage.instance.profile?.adhaar_back ==
                                    //         null
                                    ? Image.network(
                                        Storage.instance.profile?.adhaar_back ??
                                            "",
                                        fit: BoxFit.fill,
                                      )
                                    // : Container(
                                    //     color: Colors.grey[100],
                                    //     child: Center(
                                    //         child: Text('Add Aadhar back')))
                                    : Image.file(
                                        aadharBack!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            if (Storage.instance.profile?.document_status ==
                                "rejected")
                              const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (Storage.instance.profile?.document_status ==
                              "rejected") {
                            showPhotoBottomSheet(getIdFrontImage);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              margin: EdgeInsets.zero,
                              child: Container(
                                height: 150,
                                // width: 200,
                                alignment: Alignment.center,
                                child: idFront == null
                                    ?
                                    // ? Storage.instance.profile
                                    //                 ?.votercard_front == null ?
                                    Image.network(
                                        // Storage.instance.profile
                                        //         ?.passport_front ??
                                        //     "",
                                        Storage.instance.profile
                                                    ?.votercard_front ==
                                                "https://growgraphics.xyz/service-bee/public/uploads/vendors/docs"
                                            ? (Storage.instance.profile
                                                        ?.driving_license_front) ==
                                                    "https://growgraphics.xyz/service-bee/public/uploads/vendors/docs"
                                                ?
                                                //     ==
                                                // ""
                                                Storage.instance.profile
                                                        ?.passport_front ??
                                                    ""
                                                : (Storage.instance.profile
                                                        ?.driving_license_front) ??
                                                    ""
                                            // : ""
                                            : (Storage.instance.profile
                                                    ?.votercard_front) ??
                                                "",
                                        fit: BoxFit.fill,
                                      )
                                    //  : Container(
                                    //     color: Colors.grey[100],
                                    //     child: Center(
                                    //         child:Icon(Icons.add_box_outlined)))
                                    : Image.file(
                                        idFront!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            if (Storage.instance.profile?.document_status ==
                                "rejected")
                              const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (Storage.instance.profile?.document_status ==
                              "rejected") {
                            showPhotoBottomSheet(getIdBackImage);
                          }
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              margin: EdgeInsets.zero,
                              child: Container(
                                height: 150,
                                // width: 200,
                                alignment: Alignment.center,
                                child: idBack == null
                                    //? Storage.instance.profile?.votercard_back == null
                                    ? Image.network(
                                        Storage.instance.profile?.votercard_back ==
                                                "https://growgraphics.xyz/service-bee/public/uploads/vendors/docs"
                                            ? (Storage.instance.profile
                                                        ?.driving_license_back ==
                                                    "https://growgraphics.xyz/service-bee/public/uploads/vendors/docs"
                                                ? Storage.instance.profile
                                                        ?.passport_back ??
                                                    ""
                                                : Storage.instance.profile
                                                        ?.driving_license_back ??
                                                    "")
                                            : (Storage.instance.profile
                                                    ?.votercard_back ??
                                                ""),
                                        fit: BoxFit.fill,
                                      )
                                    //  : Container(
                                    //     color: Colors.grey[100],
                                    //     child: Center(
                                    //         child: Icon(Icons.add_box_outlined)))
                                    : Image.file(
                                        idBack!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            if (Storage.instance.profile?.document_status ==
                                "rejected")
                              const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Selected Services",
                      style: TextStyle(
                          fontSize: 17.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigation.instance.navigate('/cityPickEdit');
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 17.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: 320,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: Storage.instance.selected.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, pos) {
                      ServiceItem item = Storage.instance.selected[pos];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: GestureDetector(
                            onTap: () {
                              // serviceCubit.changeIndex(pos);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.blue.shade50),
                                      padding: const EdgeInsets.all(12),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${Constants.imgBaseUrl}${item.image}",
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.cover,
                                        placeholder: (context, _) =>
                                            const SizedBox(),
                                        errorWidget: (context, err, _) =>
                                            const SizedBox(),
                                      ),
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
                                            item.name ?? "",
                                            style: const TextStyle(
                                                fontSize: 14.5,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            item.desc ?? "",
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: Colors.grey.shade600,
                                                height: 1.6),
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
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Button(
                  text: "Submit",
                  onPressed: () async {
                    print(selfie?.path);
                    print(aadharFront?.path);
                    print(aadharBack?.path);
                    print(idFront?.path);
                    print(idBack?.path);
                    final response = await ApiProvider.instance.editProfile(
                        _name.text,
                        selfie?.path ??
                            Storage.instance.profile?.profile_picture,
                        aadharFront?.path ??
                            Storage.instance.profile?.adhaar_front,
                        aadharBack?.path ??
                            Storage.instance.profile?.adhaar_back,
                        Storage.instance.profile?.driving_license_front == null
                            ? (idFront?.path ??
                                Storage.instance.profile?.votercard_front)
                            : '',
                        Storage.instance.profile?.driving_license_back == null
                            ? (idBack?.path ??
                                Storage.instance.profile?.votercard_back)
                            : '',
                        Storage.instance.profile?.votercard_front == null
                            ? ''
                            : (idFront?.path ??
                                Storage
                                    .instance.profile?.driving_license_front),
                        Storage.instance.profile?.votercard_back == null
                            ? ''
                            : (idBack?.path ??
                                Storage.instance.profile?.driving_license_back),
                        Storage.instance.maps);
                    if (response.status ?? false) {
                      Navigation.instance.navigate('/NewloadingDialog');
                      final response1 =
                          await ApiProvider.instance.fetchProfile();
                      if (response1.status ?? false) {
                        Storage.instance.setProfile(response1.profile![0]);
                        Navigation.instance.navigate("/");
                      } else {
                        Navigation.instance.navigate("/main");
                      }
                    } else {
                      showError(response.message!);
                      // Navigation.instance.navigate("/main");
                    }
                  }),
            ],
          ),
        )
        ,
      ),
    );
  }

  void showError(String msg) {
    AlertX.instance.showAlert(
        title: "Error",
        msg: msg,
        positiveButtonText: "Done",
        positiveButtonPressed: () {
          Navigation.instance.goBack();
        });
  }

  void showMsg(String msg) {
    AlertX.instance.showAlert(
        title: "Details",
        msg: msg,
        positiveButtonText: "Notification",
        negativeButtonText: "Back",
        negativeButtonPressed: () {
          Navigation.instance.goBack();
        },
        positiveButtonPressed: () {
          Navigation.instance.navigate("/notificationPage");
         
        });
  }

  Future<void> getSelfieImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    //(index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selfie = File(pickedFile.path);
      });
    }
  }

  Future<void> getAadharFrontImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    //(index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        aadharFront = File(pickedFile.path);
      });
    }
  }

  Future<void> getAadharBackImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    //  (index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        aadharBack = File(pickedFile.path);
      });
    }
  }

  Future<void> getIdFrontImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    // (index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        idFront = File(pickedFile.path);
      });
    }
  }

  Future<void> getIdBackImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    // (index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        idBack = File(pickedFile.path);
      });
    }
  }

  void showPhotoBottomSheet(Function(int) getImage) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    BuildContext? context = Navigation.instance.navigatorKey.currentContext;
    if (context != null) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Center(
                    child: Text(
                  "Add Photo",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                )),
                contentPadding: EdgeInsets.only(top: 24, bottom: 30),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigation.instance.goBack();
                              getImage(0);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.pink.shade300),
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                Text("Camera",
                                    style: TextStyle(
                                      fontSize: 14,
                                    )),
                              ],
                            )),
                        // SizedBox(
                        //   width: 42,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       Navigation.instance.goBack();
                        //       getImage(1);
                        //     },
                        //     child: Column(
                        //       children: [
                        //         Container(
                        //           padding: EdgeInsets.all(12),
                        //           margin: EdgeInsets.only(bottom: 4),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(30),
                        //               color: Colors.purple.shade300),
                        //           child: Icon(
                        //             EvaIcons.image,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //         Text("Gallery",
                        //             style: TextStyle(
                        //               fontSize: 14,
                        //             )),
                        //       ],
                        //     )),
                      ],
                    ),
                  ],
                ));
          });
    }
  }
}
