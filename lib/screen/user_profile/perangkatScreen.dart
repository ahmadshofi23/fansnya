import 'dart:developer';

import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerangkatScreen extends StatefulWidget {
  const PerangkatScreen({Key? key}) : super(key: key);

  @override
  State<PerangkatScreen> createState() => _PerangkatScreenState();
}

class _PerangkatScreenState extends State<PerangkatScreen> {
  String? noHp;
  String? email;
  List<dynamic> device = [];
  Future getInformationDeviceConnected() async {
    String? token;
    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('login');

      final MutationOptions options = MutationOptions(
          document: gql(MultiQuery().getDeviceConnnected),
          variables: {'token': token});
      QueryResult result = await MultiQuery().client.value.mutate(options);
      log(result.data.toString());
      log(result.data!['keepLogin']['user']['devices'].toString());
      setState(() {
        noHp = result.data!['keepLogin']['user']['phone_number']
                ['phone_number_str']
            .toString();
        email =
            result.data!['keepLogin']['user']['email']['email_str'].toString();
        device = result.data!['keepLogin']['user']['devices'];

        log(device.toString());
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getInformationDeviceConnected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: blackColor)),
        title: Text(
          "Perangkat Terhubung",
          style: TextStyle(color: blackColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            SizedBox(height: screenHeight * 0.024),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nomor Handphone Terdaftar",
                  style: TextStyle(
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                Text(
                  noHp != null ? noHp.toString() : "",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Terdaftar",
                  style: TextStyle(
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                Text(
                  email != null ? email.toString() : "",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.024),
            Divider(),
            Expanded(
                child: device.length == null
                    ? Container()
                    : ListView.builder(
                        itemCount: device.length,
                        itemBuilder: (context, index) {
                          // DateTime tempDate = new DateFormat('dd-MM-yyyy hh:mm')
                          //     .parse(device[index]['last_login']);
                          String date = DateFormat('dd-MM-yyyy')
                              .parse(device[index]['last_login'])
                              .toString();
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: greyColor, width: 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone_android_outlined,
                                      color: primaryColor,
                                      size: screenHeight * 0.1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          device[index]['model_name'],
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.06,
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
                                          ),
                                        ),
                                        // SizedBox(height: screenHeight * 0.0),
                                        Text(
                                          "Log in terakhir:",
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.05,
                                            color: textGray,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          device[index]['last_login']
                                              .toString()
                                              .replaceAll('T', " ")
                                              .substring(0, 16),
                                          style: TextStyle(
                                            color: textGray,
                                            fontSize: screenWidth * 0.05,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/logo.png",
                                              height: screenHeight * 0.035,
                                            ),
                                            SizedBox(width: screenWidth * 0.01),
                                            Text(
                                              "FansNya FKBN",
                                              style: TextStyle(
                                                color: textGray,
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenWidth * 0.05,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
