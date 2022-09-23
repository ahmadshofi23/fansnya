import 'package:animate_do/animate_do.dart';
import 'package:fkbn_flutter/screen/login/loginScreen.dart';
import 'package:fkbn_flutter/screen/register/registrasiScreen.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 10,
              left: 20,
              child: FadeInUp(
                duration: Duration(milliseconds: 1000),
                child: Text(
                  "Cerdas, Waskit\ndan Militan.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    color: whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: FadeInUp(
                delay: Duration(milliseconds: 700),
                duration: Duration(milliseconds: 1200),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.04,
                        horizontal: screenWidth * 0.04),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: btnColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  )),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => RegistrasiScreen())),
                              child: Text(
                                "Buat Akun",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: screenWidth * 0.04),
                              )),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        SizedBox(
                          height: screenHeight * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: whiteColor,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: primaryColor, width: 2),
                                    borderRadius: BorderRadius.circular(28),
                                  )),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  )),
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: screenWidth * 0.04),
                              )),
                        ),
                        SizedBox(height: screenHeight * 0.06),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lewati",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                  fontSize: screenWidth * 0.04),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
