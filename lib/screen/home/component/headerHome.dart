import 'package:fkbn_flutter/screen/user_profile/userProfileScreen.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.016),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: screenHeight * 0.07,
                ),
              ),
              SizedBox(width: screenWidth * 0.016),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth * 0.45,
                    child: Text(
                      "Forum Kader Bela Negara",
                      style: TextStyle(
                        fontSize: screenWidth * 0.042,
                        fontWeight: FontWeight.w700,
                        color: secondColor,
                      ),
                    ),
                  ),
                  Text(
                    "FKBN DKI Jakarta",
                    style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      fontWeight: FontWeight.w700,
                      color: secondColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: screenHeight * 0.04,
                    height: screenHeight * 0.04,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/bell.png"))),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen())),
                  child: Container(
                    width: screenHeight * 0.04,
                    height: screenHeight * 0.04,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/chart.png"))),
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileScreen())),
                    child: CircleAvatar()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
