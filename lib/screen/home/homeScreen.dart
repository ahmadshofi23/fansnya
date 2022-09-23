import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fkbn_flutter/data/user_model.dart';
import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/screen/home/component/card.dart';
import 'package:fkbn_flutter/screen/home/component/cardScroll.dart';
import 'package:fkbn_flutter/screen/home/component/headerHome.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // varvar data data;

  String name = "";

  Future getUsername() async {
    String? data;
    try {
      final prefs = await SharedPreferences.getInstance();
      data = prefs.getString('login');
      final MutationOptions options =
          MutationOptions(document: gql(MultiQuery().getName), variables: {
        'token': data,
      });
      QueryResult result = await MultiQuery().client.value.mutate(options);
      // log(result.data!['keepLogin']['user']['full_name'].toString());
      setState(() {
        name = result.data!['keepLogin']['user']['full_name'].toString();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    // getToken();
    getUsername();
    // getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6).withOpacity(0.99),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderHome(),
              Text(
                "Selamat Datang,",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  color: blackColor,
                ),
              ),
              Text(
                name == "" ? "" : name.toString(),
                style: TextStyle(
                  color: redColor,
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.06,
                ),
              ),
              SizedBox(height: screenHeight * 0.016),
              CardScroll(),
              SizedBox(height: screenHeight * 0.024),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CardMenu(
                            title: "Kartu Anggota",
                            image: "assets/images/sertifikat.png"),
                        SizedBox(width: screenWidth * 0.05),
                        CardMenu(
                            title: "Sertifikat",
                            image: "assets/images/sertifikat.png"),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        CardMenu(
                            title: "Transaksi",
                            image: "assets/images/shopping.png"),
                        SizedBox(width: screenWidth * 0.05),
                        CardMenu(
                            title: "Aktivitas",
                            image: "assets/images/military.png"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Image.asset("assets/icons/logoFansnya.png"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: screenHeight * 0.08,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(Icons.home, size: screenHeight * 0.04),
                          Text("Home"),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(Icons.event, size: screenHeight * 0.04),
                          Text("Event"),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 0.00001,
                      ),
                      child: Text(
                        "Fansya",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: redColor,
                        ),
                      ),
                    )),
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(Icons.home, size: screenHeight * 0.04),
                          Text("FKBN"),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Column(
                        children: [
                          Icon(Icons.shopping_bag_outlined,
                              size: screenHeight * 0.04),
                          Text("Shop"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
