import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:service_bee/constants.dart';
import 'package:service_bee/storage/storage.dart';

class BannerWidget extends StatefulWidget {
  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  List<String> images = [
    "https://img.freepik.com/free-psd/delivery-horizontal-banner-template_23-2148943857.jpg?size=626&ext=jpg&ga=GA1.2.1131756573.1638728824",
    "https://img.freepik.com/free-psd/technology-banner-template_23-2148928991.jpg?size=626&ext=jpg&ga=GA1.2.1131756573.1638728824",
    "https://img.freepik.com/free-psd/digital-marketing-agency-corporate-web-banner-template_106176-529.jpg?size=626&ext=jpg&ga=GA1.2.1131756573.1638728824",
    "https://img.freepik.com/free-psd/digital-marketing-live-webinar-corporate-web-banner-template_106176-536.jpg?size=626&ext=jpg&ga=GA1.2.1131756573.1638728824"
  ];

  int _currentIndex = 0;

  void onPageChanged(int index, _) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget placeholder() {
    return Container(
      color: Colors.grey.shade100,
      width: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: Storage.instance.banners.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: "${Constants.url}${i.ad}" ?? "",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, _) => placeholder(),
                      errorWidget: (context, err, _) => placeholder(),
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
              height: 200, viewportFraction: 1, onPageChanged: onPageChanged),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              Storage.instance.banners.length,
              (index) => Container(
                    height: 7,
                    width: 7,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                        color: (_currentIndex == index)
                            ? Colors.black
                            : Constants.secondaryColor,
                        shape: BoxShape.circle),
                  )),
        ),
      ],
    );
  }
}
