import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:fkbn_flutter/screen/home/homeScreen.dart';
import 'package:fkbn_flutter/screen/onBoarding/onBoardingScreen.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("login");
    if (val != null) {
      Timer(
        Duration(seconds: 4),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false),
      );
    } else {
      Timer(
          Duration(seconds: 4),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (contex) => OnBoardingScreen())));
    }
  }

  @override
  void initState() {
    checkLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        secondColor.withOpacity(0.9),
        primaryColor.withOpacity(0.5),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Spacer(),
                FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: screenHeight * 0.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.024),
                FadeInUp(
                  delay: Duration(milliseconds: 700),
                  duration: Duration(milliseconds: 1200),
                  child: Text(
                    "Forum Kader Bela Negara",
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                FadeInUp(
                  delay: Duration(milliseconds: 1000),
                  duration: Duration(milliseconds: 1200),
                  child: Text(
                    "Powered by",
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: whiteColor,
                    ),
                  ),
                ),
                FadeInUp(
                  delay: Duration(milliseconds: 1200),
                  duration: Duration(milliseconds: 1400),
                  child: Image.asset(
                    "assets/images/FansNya.png",
                    height: screenWidth * 0.05,
                  ),
                ),
                Spacer(),
                FadeInUp(
                  delay: Duration(milliseconds: 1400),
                  duration: Duration(milliseconds: 1600),
                  child: Text(
                    "PT. Teknologi Sosial Nusantara",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: whiteColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                )
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold();
  }
}
