import 'dart:convert';
import 'dart:developer';

import 'package:fkbn_flutter/data/user_model.dart';
import 'package:fkbn_flutter/screen/user_profile/akunScreen.dart';
import 'package:fkbn_flutter/screen/user_profile/button.dart';
import 'package:fkbn_flutter/screen/user_profile/dataDiriScreen.dart';
import 'package:fkbn_flutter/screen/user_profile/editProfile.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UserModel data = UserModel();

  Future getUser() async {
    final user = await SharedPreferences.getInstance();
    Map<String, dynamic> dataUser = jsonDecode(user.getString("users")!);
    data = UserModel.fromJson(dataUser);
    log(data.toString());
    log("email yang di passing");
    log(data.email.toString());
    log(data.fullName.toString());
    // setState(() {
    //   text = data.fullName.toString();
    // });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
        ),
        title: Text(
          "Akun Saya",
          style: TextStyle(color: blackColor),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.055),
                    Container(
                      height: screenHeight * 0.15,
                      width: screenHeight * 0.15,
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.022),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.fullName.toString(),
                          style: TextStyle(
                            color: blackColor,
                            fontSize: screenWidth * 0.064,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        IconButton(
                            onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfile(),
                                  ),
                                ),
                            icon: Image.asset(
                              "assets/icons/edit.png",
                              height: screenWidth * 0.06,
                            )),
                      ],
                    ),
                    Text(
                      data.email.toString(),
                      style: TextStyle(
                        color: greyColor,
                        fontSize: screenWidth * 0.040,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.027),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Container(
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TabBar(
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: primaryColor,
                            ),
                            tabs: [
                              Tab(
                                child: Center(
                                  child: Text(
                                    "Data Diri",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenWidth * 0.05,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Center(
                                  child: Text(
                                    "Akun",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenWidth * 0.05,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 1.43,
                      child: TabBarView(children: [
                        DataDiriScreen(),
                        AkunScreen(),
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
