import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';

class CardMenu extends StatelessWidget {
  CardMenu({Key? key, required this.title, required this.image})
      : super(key: key);
  String title;
  String image;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: screenHeight * 0.2,
        // color: blackColor,
        // width: screenWidth * 0.4,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: whiteColor,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ], borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.04,
                top: screenHeight * 0.02,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  image,
                  height: screenHeight * 0.17,
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          ],
        ),
        // Stack(
        //   children: [
        //     Positioned(
        //       bottom: -50,
        //       right: 10,
        //       child: Image.asset(
        //         "assets/images/sertifikat.png",
        //         height: screenHeight * 0.24,
        //         // width: screenWidth * 0.3,
        //         fit: BoxFit.fitHeight,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
