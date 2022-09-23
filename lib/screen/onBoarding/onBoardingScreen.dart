import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fkbn_flutter/screen/landing/landingScreen.dart';
import 'package:fkbn_flutter/screen/onBoarding/componentOnBoarding/sliderPage.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentIndex = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
        title: "Lihat berita terbaru FKBN",
        image: "assets/images/adjusted.png",
        description:
            "Dengan Fansnya FKBN, berita maupun dokumentasi kegiatan terbaru FKBN didapatkan dengan mudah dan lengkap"),
    SliderPage(
        title: "Pelatihan FKBN",
        image: "assets/images/morningrun.png",
        description:
            "Ikuti berbagai macam pelatihan FKBN dengan mudah dan didapatkan pelantikannya!"),
    SliderPage(
        title: "Merchandise",
        image: "assets/images/onlineShop.png",
        description:
            "Dapatkan perlengkapan seragam dengan mudah dan pasti barang 100% asli"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/bgOnBoarding.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Expanded(
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                          if (index == 2) {
                            Timer(
                              Duration(seconds: 1),
                              () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LandingScreen()));
                              },
                            );
                          }
                        });
                      },
                      itemBuilder: (contex, index) {
                        return _pages[index];
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(_pages.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 10,
                        width: 10,
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == _currentIndex)
                              ? primaryColor
                              : whiteColor,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.26,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
