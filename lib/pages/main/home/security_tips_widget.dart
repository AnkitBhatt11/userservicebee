import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:service_bee/storage/storage.dart';

class SecurityTipsWidget extends StatelessWidget {
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.blueGrey,
    Colors.red,
  ];

  Widget placeholder() {
    return Container(
      color: Colors.grey.shade100,
      width: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Security Tips",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Learn to invest in Service Bee in just 4 steps",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
                  Storage.instance.textBanners.length,
                  (index) => Container(
                        alignment: Alignment.center,
                        height: 80,
                        width: 160,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(4)),
                        margin: const EdgeInsets.only(right: 16),
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: Text(
                          Storage.instance.textBanners[index].ad ??
                              "Learn to invest in Service Bee in just 4 steps.Learn to invest in Service Bee in just 4 steps",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, height: 1.6, fontSize: 13),
                        ),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
