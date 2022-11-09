import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:google_maps_webservice/places.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 12),
        child: SafeArea(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  //   child: _handlePressButton(),
                  // child: GooglePlaceAutoCompleteTextField(
                  //     textEditingController: searchController,
                  //     //googleAPIKey: "AIzaSyDKjQNkMiD4zxpijGTrx4NuTbTxMAgYh3M",
                  //     googleAPIKey: "AIzaSyC-29KZIc0M_3Yw3LQXDjx3dg7ifMRUyhg",
                  //     inputDecoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.grey.shade100,
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(4),
                  //           borderSide:
                  //               BorderSide(color: Colors.grey.shade200)),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(4),
                  //           borderSide:
                  //               BorderSide(color: Colors.grey.shade200)),
                  //       contentPadding:
                  //           const EdgeInsets.only(left: 16, right: 16),
                  //       hintText: "Search Location",
                  //     ),
                  //     countries: const ["in"],
                  //     isLatLngRequired: true,
                  //     getPlaceDetailWithLatLng: (Prediction prediction) async {
                  //       print(
                  //           'prediction ${prediction.id} ${prediction.description}');
                  //       var data = prediction.description?.split(',')[0];
                  //       Navigator.pop(context, data ?? prediction.description);
                  //     },
                  //     itmClick: (Prediction prediction) {
                  //       FocusManager.instance.primaryFocus?.unfocus();
                  //     }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
