import 'dart:async';

import 'package:flutter/material.dart';
import 'package:service_bee/model.dart';
import 'package:service_bee/pages/login/sendOtp/send_otp_page.dart';

import '../components/button.dart';

import '../main.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({Key? key}) : super(key: key);

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  final List<OnBoardingItem> _items = [
    OnBoardingItem(
      title: "Heading 1",
      secondaryTitle:
          "Lorem ipsum dolar sit amet dolar ipsum lorem mio is dolar",
      image: 'assets/images/logo.png'
    ),
    OnBoardingItem(
      title: "Heading 2",
      secondaryTitle:
      "Lorem ipsum dolar sit amet dolar ipsum lorem mio is dolar",
      image: 'assets/images/logo.png',
    ),
    OnBoardingItem(
      title: "Heading 3",
      secondaryTitle:
      "Lorem ipsum dolar sit amet dolar ipsum lorem mio is dolar",
      image:'assets/images/logo.png'
    ),
  ];
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? timer;

  void onChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex == 0) {
        _controller.animateTo(MediaQuery.of(context).size.width,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (_currentIndex == 1) {
        _controller.animateTo(MediaQuery.of(context).size.width * 2,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (_currentIndex == 2) {
        _controller.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _items.length,
                onPageChanged: onChanged,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, pos) {
                  OnBoardingItem item = _items[pos];
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          color: Colors.white,
                          padding: const EdgeInsets.all(30),
                          child: Image.asset(item.image),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        item.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          item.secondaryTitle,
                          style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.grey.shade600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i = 0; i < _items.length; i++)Container(
                  height: 4,
                  width: 12,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: (i == _currentIndex) ? Colors.black : Colors.black.withOpacity(0.25)
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Button(
                  text: "Get Started",
                  onPressed: () async {
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SendOtpPage()));
                 //   Navigator.pushReplacementNamed(context, Routes.Sign);
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
