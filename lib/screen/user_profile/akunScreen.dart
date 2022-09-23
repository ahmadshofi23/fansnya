import 'dart:async';
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/screen/landing/landingScreen.dart';
import 'package:fkbn_flutter/screen/user_profile/changePasswordScreen.dart';
import 'package:fkbn_flutter/screen/user_profile/perangkatScreen.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class AkunScreen extends StatefulWidget {
  const AkunScreen({Key? key}) : super(key: key);

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  String? data;

  Future showMessanger(BuildContext context, String message) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future logout() async {
    final info = NetworkInfo();
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    final ipAddress = await info.getWifiIP();
    final modelName = androidDeviceInfo.model;

    try {
      final MutationOptions options =
          MutationOptions(document: gql(MultiQuery().logout), variables: {
        'token': data.toString(),
        'ipAddress': ipAddress.toString(),
        'modelName': modelName.toString(),
      });
      final QueryResult result =
          await MultiQuery().client.value.mutate(options);
      if (result.data!['logout']['message'] != null) {
        log(result.data!['logout']['message'].toString());
        log(ipAddress.toString());
        log(data.toString());
        log(modelName.toString());
        removeSessionLogin();
        // showMessanger(context, "Log Out Success");
        Timer(
          Duration(seconds: 2),
          () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LandingScreen(),
              ),
              (route) => false),
        );
      } else {
        showMessanger(context, "Logout Gagal!!!");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    data = await prefs.getString('login');
  }

  @override
  void initState() {
    // TODO: implement initState
    getToken();

    super.initState();
  }

  removeSessionLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Logout Success!!!!",
      ),
      duration: Duration(seconds: 2),
    ));
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const LandingScreen()),
    //     (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidht = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenWidht * 0.02, horizontal: screenWidht * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ubah Password",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidht * 0.04),
              ),
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword())),
                  icon: Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Perangkat Terhubung",
                style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidht * 0.04),
              ),
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PerangkatScreen())),
                  icon: Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
          SizedBox(height: screenWidht * 0.7),
          InkWell(
            onTap: () {
              // _googleSignIn.disconnect();
              logout();
            },
            child: Row(
              children: [
                Icon(
                  Icons.exit_to_app_outlined,
                  color: redColor,
                  size: screenWidht * 0.08,
                ),
                SizedBox(width: screenWidht * 0.012),
                Text(
                  "Keluar Akun",
                  style: TextStyle(
                      color: redColor,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidht * 0.04),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
