import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTexField extends StatelessWidget {
  CustomTexField(
      {Key? key,
      required this.icon,
      required this.hintTextTitle,
      this.controller,
      this.onPressed})
      : super(key: key);
  final String icon;
  final String hintTextTitle;
  final TextEditingController? controller;
  final void Function(String)? onPressed;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return TextFormField(
      controller: controller,
      onChanged: onPressed,
      style: TextStyle(fontSize: screenWidth * 0.04, color: blackColor),
      decoration: InputDecoration(
        prefixIcon: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02, vertical: screenHeight * 0.01),
            child: Image.asset(
              icon,
              height: screenHeight * 0.03,
            ),
          ),
        ),
        hintText: hintTextTitle,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: greyColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
