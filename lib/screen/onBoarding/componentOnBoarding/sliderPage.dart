import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SliderPage extends StatelessWidget {
  SliderPage(
      {Key? key,
      required this.title,
      required this.image,
      required this.description})
      : super(key: key);
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
      ),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            // Spacer(),
            Image.asset(
              image,
              width: screenWidth * 0.8,
            ),
            SizedBox(height: screenHeight * 0.034),

            Text(
              title,
              style: TextStyle(fontSize: screenWidth * 0.05, color: whiteColor),
            ),
            SizedBox(height: screenHeight * 0.032),
            Text(
              description,
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: screenWidth * 0.035, color: whiteColor),
            ),
            SizedBox(height: screenHeight * 0.032),
          ],
        ),
      ),
    );
  }
}
