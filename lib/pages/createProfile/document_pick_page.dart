import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_bee/components/button.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/navigation/navigation.dart';
import 'package:service_bee/network/api_provider.dart';
import 'package:service_bee/storage/storage.dart';

import '../../components/alert.dart';
import '../../helpers.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DocumentPickPage extends StatefulWidget {
  @override
  State<DocumentPickPage> createState() => _DocumentPickPageState();
}

class _DocumentPickPageState extends State<DocumentPickPage> {
  ImagePicker imagePicker = ImagePicker();
  File? selfie;
  File? aadharFront;
  File? aadharBack;
  File? idFront;
  File? idBack;
  String selectedId = "Voter Id";
  List<String> ids = ["Voter Id", "Driving License", "Passport"];
  TextEditingController nameController = TextEditingController();

  Future<void> getSelfieImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera
        //  (index == 0) ?
        //   ImageSource.camera :
        //   ImageSource.gallery
        );
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
    //(index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        aadharBack = File(pickedFile.path);
      });
    }
  }

  Future<void> getIdFrontImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    //(index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        idFront = File(pickedFile.path);
      });
    }
  }

  Future<void> getIdBackImage(int index) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    //(index == 0) ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        idBack = File(pickedFile.path);
      });
    }
  }

  var currentAgree = true;
  Widget documentImageWidget(
      File? image, String text, Function(int) onPressed) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (text == "Back ") {
              listScrollController.animateTo(
                listScrollController.position.maxScrollExtent,
                duration: Duration(seconds: 2),
                curve: Curves.easeOut,
              );
            }
            Helpers().showPhotoBottomSheet(onPressed);
          },
          child: (image != null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(
                    image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: double.infinity,
                  ))
              : Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  margin: EdgeInsets.zero,
                  child: Container(
                      height: 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Constants.secondaryColor),
                        padding: const EdgeInsets.all(16),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      )),
                ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 4,
        ),
        // MaterialButton(
        //   onPressed: () {
        //     Helpers().showPhotoBottomSheet(onPressed);
        //   },
        //   color: Colors.black,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(4),
        //   ),
        //   elevation: 0,
        //   child: const Text(
        //     "Upload",
        //     style: TextStyle(
        //         color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
        //   ),
        // )
      ],
    );
  }

  Widget idField() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton<String>(
            value: selectedId,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey,
            ),
            underline: const SizedBox(),
            items: ids
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (val) {
              setState(() {
                selectedId = val ?? "Voter Id";
              });
            }),
      ),
    );
  }

  ScrollController listScrollController = ScrollController();
//final position = listScrollController.position.maxScrollExtent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 50),
      //   child: Container(
      //     height: 50,
      //     child: LoadingIndicator(
      //         indicatorType: Indicator.ballScale,
      //         colors: const [Colors.blueGrey],
      //         strokeWidth: 2,
      //         backgroundColor: Colors.transparent,
      //         pathBackgroundColor: Colors.transparent),
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: listScrollController,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Upload Documents",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Provide details to prove your identity",
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: "Enter your Name",
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Aadhar Card",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: documentImageWidget(
                              aadharFront, "Front", getAadharFrontImage),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: documentImageWidget(
                              aadharBack, "Back", getAadharBackImage),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Select the following options",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    idField(),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: documentImageWidget(
                              idFront, "Front", getIdFrontImage),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: documentImageWidget(
                              idBack, "Back ", getIdBackImage),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Upload Selfie",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Helpers().showPhotoBottomSheet(getSelfieImage);
                      },
                      child: (selfie != null)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.file(
                                selfie!,
                                fit: BoxFit.cover,
                                height: 180,
                                width: double.infinity,
                              ))
                          : Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              margin: EdgeInsets.zero,
                              child: Container(
                                  height: 180,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Constants.secondaryColor),
                                    padding: const EdgeInsets.all(16),
                                    child: const Icon(
                                      Icons.add_rounded,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  )),
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        // color: Colors.black45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: currentAgree,
                                onChanged: (val) {
                                  setState(() {
                                    currentAgree = !currentAgree;
                                  });
                                  // SetState(() {
                                  //   currentAgree = !currentAgree;
                                  // });
                                }),
                            GestureDetector(
                              onTap: () {
                                showAlertDialog(context);
                              },
                              child: Text(
                                'I accept Terms & Conditions',
                                style: TextStyle(
                                  color: Color(0xffF19613),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Button(
                    text: "Submit",
                    onPressed: () async {
                      print(selfie?.path);
                      print(aadharFront?.path);
                      print(aadharBack?.path);
                      print(idFront?.path);
                      print(idBack?.path);
                      //  Navigation.instance.navigate("/NewloadingDialog");
                      // if (currentAgree == true) {
                      if (nameController.text.isNotEmpty &&
                          selfie?.path != null &&
                          aadharFront?.path != null &&
                          aadharBack?.path != null &&
                          idFront?.path != null &&
                          idFront?.path != null &&
                          currentAgree == true) {
                        Navigation.instance.navigate("/NewloadingDialog");
                        final response = await ApiProvider.instance.addProfile(
                            nameController.text,
                            selfie?.path,
                            aadharFront?.path,
                            aadharBack?.path,
                            selectedId == 'Voter Id' ? (idFront?.path) : '',
                            selectedId == 'Voter Id' ? (idBack?.path) : '',
                            selectedId == 'Driving License'
                                ? idFront?.path
                                : selectedId == 'Voter Id'
                                    ? ''
                                    : '',
                            selectedId == 'Driving License'
                                ? idBack?.path
                                : selectedId == 'Voter Id'
                                    ? ''
                                    : '',
                            selectedId == 'Passport'
                                ? idFront?.path
                                : selectedId == 'Voter Id'
                                    ? ''
                                    : '',
                            selectedId == 'Passport'
                                ? idFront?.path
                                : selectedId == 'Voter Id'
                                    ? ''
                                    : '',
                            Storage.instance.maps);
                        if (response.status ?? false) {
                          Navigation.instance.navigate("/");
                        } else {
                          Navigation.instance.goBack();
                          showError(response.message!);
                          Navigation.instance.navigate("/main");
                        }
                      } else {
                        if (nameController.text.isEmpty ||
                            selfie?.path == null ||
                            aadharFront?.path == null ||
                            aadharBack?.path == null ||
                            idFront?.path == null ||
                            idFront?.path == null) {
                          showError('Fill all the details !');
                        } else if (currentAgree == false) {
                          showError('Terms and conditions not accepted');
                        } else {
                          showError('Fill all the details !');
                        }
                      }
                      // } else {
                      //   showError('Terms and conditions not accepted');
                      // }
                    }),
              ),
            )
          ],
        ),
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

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Terms and Conditions'),
            content: Container(
              height: 150,
              child: Center(
                child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam'),
              ),
            ),
          );
        });
      },
    );
  }
}
