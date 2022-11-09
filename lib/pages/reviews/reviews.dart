import 'package:flutter/material.dart';
import 'package:service_bee/network/api_provider.dart';

import '../../models/review.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Reviews",
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
      body: Container(
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (cont, count) {
              var data = reviews[count];
              return Column(
                children: [
                  Card(
                    color: Colors.grey.shade100,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: ImageIcon(
                                          AssetImage(
                                              "assets/images/account.png"),
                                          color: Colors.grey.shade700,
                                          size: 30,
                                        ),
                                        // child: CircleAvatar(
                                        //     backgroundColor: Colors.white,
                                        //     radius: 30,
                                        //     backgroundImage: AssetImage(
                                        //         "assets/images/account.png")
                                        //     //  NetworkImage(
                                        //     //     "https://growgraphics.xyz/service-bee/public/" +
                                        //     //             "${data.profile_picture}" ??
                                        //     //         ""),
                                        //     ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 45,
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${data.rating}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.created_at == null
                                              ? ''
                                              : '${data.created_at.toString().substring(8, 10)}' +
                                                  '-' +
                                                  '${data.created_at.toString().substring(5, 7)}' +
                                                  '-' +
                                                  '${data.created_at.toString().substring(0, 4)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.phone ?? "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.email == ''
                                              ? "Email Not Available"
                                              : data.email ?? "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () {},
                                        //   child: Container(
                                        //     width: 45,
                                        //     padding: EdgeInsets.all(3),
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.black,
                                        //       borderRadius: BorderRadius.all(
                                        //         Radius.circular(10),
                                        //       ),
                                        //     ),
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment
                                        //               .spaceBetween,
                                        //       children: [
                                        //         Text(
                                        //           '${data.rating}',
                                        //           style: TextStyle(
                                        //             fontSize: 14,
                                        //             color: Colors.white,
                                        //           ),
                                        //         ),
                                        //         Icon(
                                        //           Icons.star,
                                        //           color: Colors.white,
                                        //           size: 15,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data.review ?? "",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // children: [],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              );
            }),
      ),
    );
  }

  void fetchReviews() async {
    final response = await ApiProvider.instance.getReviews();
    if (response.status ?? false) {
      setState(() {
        reviews = response.reviews ?? [];
      });
    }
  }
}
