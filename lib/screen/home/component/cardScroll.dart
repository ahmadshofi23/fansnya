import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardScroll extends StatelessWidget {
  const CardScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.14,
            decoration: BoxDecoration(
              // color: blackColor,
              // boxShadow: [
              //   BoxShadow(
              //     color: greyColor.withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(0, 30),
              //   )
              // ],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(
              "assets/images/Ads1.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.014),
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.asset(
                "assets/images/Ads1.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
