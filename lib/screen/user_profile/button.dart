import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonProfile extends StatelessWidget {
  ButtonProfile({Key? key, required this.title, required this.press})
      : super(key: key);
  String title;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.06,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: btnColor,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            )),
        onPressed: press,
        child: Text(
          title,
          style: TextStyle(color: whiteColor, fontSize: screenWidth * 0.04),
        ),
      ),
    );
  }
}
