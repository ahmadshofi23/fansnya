// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fkbn_flutter/data/ResponseLogin.dart';
import 'package:fkbn_flutter/data/user_model.dart';
import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/screen/home/homeScreen.dart';
import 'package:fkbn_flutter/screen/register/componentRegistrasi/customeTexfield.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  bool _isPasswordEightCharacter = false;
  bool _isPasswordhasNumber = false;
  bool _disableButton = true;
  bool isLogin = false;
  bool showLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();

  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  Future loginByGoogle() async {
    // GoogleSignInAccount ;
  }

  onPasswordCheck(String password) {
    final checkNumberPassword = RegExp(r'[0-9]');
    setState(() {
      _isPasswordEightCharacter = false;
      if (password.length >= 8) {
        _isPasswordEightCharacter = true;

        _isPasswordhasNumber = false;
        _disableButton = true;
        if (checkNumberPassword.hasMatch(password)) {
          _isPasswordhasNumber = true;
          _disableButton = false;
        }
      }
    });
  }

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });

      return;
    }
    log(user.serverAuthCode.toString());
    log(user.id.toString());
    log(user.authHeaders.toString());
    log(user.displayName.toString());
    log(user.authentication.toString());
    // log('People API ${response.statusCode} response: ${response.body}');
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future showMessanger(BuildContext context, String message) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future getIP() async {
    // await Permission.location.request();
    // final info = NetworkInfo();
    // final ipV4 = await Ipify.ipv4();
    // final ipv6 = await Ipify.ipv64();
    // final geo = await Ipify.geo("at_YS0ZOXp7y3nnksOqoZUo6qAag5LbY");
    // print("IP PUBLIC V4: " + ipV4.toString());
    // print("IP PUBLIC V6: " + ipv6.toString());
    // print("GEO KOTA:" + geo.location!.city.toString());
    // print("GEO  COUNTRY :" + geo.location!.country.toString());
    // print("GEO  LAT :" + geo.location!.lat.toString());
    // print("GEO  LNG :" + geo.location!.lng.toString());
    // print("GEO  REGION :" + geo.location!.region.toString());
    // print("GEO  NAME ID :" + geo.location!.geonameId.toString());
    // print("GEO IP PUBLIC:" + geo.ip.toString());
    // print("GEO ISP :" + geo.isp.toString());
    // var ipAddress = await info.getWifiIP();
    // var ssid = await info.getWifiName();
    // print("INI SSID :" + ssid.toString());
    // print("INI IP :" + ipAddress.toString());
  }

  Future getDeviceInfo() async {
    // var imeaNo = await DeviceInformation.deviceIMEINumber;
    // print(" IMEA" + imeaNo.toString());
    // DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    // final map = androidInfo.toMap();

    // print(androidInfo.manufacturer.toString());
    // print(androidInfo.hardware.toString());
    // print(androidInfo.device.toString());
    // print(androidInfo.host.toString());
    // print(androidInfo.id.toString());
    // print(androidInfo.model.toString());
    // print(androidInfo.product.toString());
    // print(androidInfo.type.toString());
    // print(androidInfo.systemFeatures.toString());
    // print(androidInfo.version.codename.toString());
    // print(androidInfo.version.baseOS.toString());
    // print(androidInfo.version.incremental.toString());
    // print(androidInfo.tags.toString());
  }

  Future forgotPassword() async {
    try {
      final MutationOptions options = MutationOptions(
          document: gql(MultiQuery().forgotPassword),
          variables: {
            'email': emailController.text,
          });
      print(emailController.text);
      final QueryResult result =
          await MultiQuery().client.value.mutate(options);

      if (result.data!['forgotPassword']['message'] != null) {
        showMessanger(
            context, result.data!['forgotPassword']['message'].toString());
      } else {
        showMessanger(context,
            "Tidak dapat mengirim link forgot passowrd, harap periksa email anda!!!");
      }
    } catch (e) {
      log("Failed access Query");
    }
  }

  checkLogin(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("login", token);
  }

  Future saveUser(String email, String fullName, String password) async {
    final user = await SharedPreferences.getInstance();
    // Map<String, dynamic> users = {
    //   'email': email,
    //   'fullName': fullName,
    // };
    UserModel dataUser =
        UserModel(email: email, fullName: fullName, password: password)
            as UserModel;
    String users = jsonEncode(dataUser);
    // log(users['email'].toString());
    // UserModel data = UserModel.fromJson(users);
    await user.setString("users", users);
  }

  Future addDevice(String token) async {
    final info = NetworkInfo();
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    try {
      final MutationOptions options =
          MutationOptions(document: gql(MultiQuery().deviceInfo), variables: {
        'token': token,
        'imei': "",
        'modelName': androidDeviceInfo.model.toString(),
        'brand': androidDeviceInfo.brand.toString(),
        'macAddress': "",
        'ipAddress': info.getWifiIP().toString(),
        'manufacturer': androidDeviceInfo.manufacturer.toString(),
        'androidId': androidDeviceInfo.androidId.toString(),
        'iosId': "",
        'latitude': "",
        'longitude': "",
      });
      final QueryResult result =
          await MultiQuery().client.value.mutate(options);
      if (result.data!['deviceInfo']['message'] != null) {
        log(result.data!['deviceInfo']['message'].toString());
      } else {
        log(result.data!['deviceInfo']['error'].toString());
        log(token.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ResponseLogin?> loginAccount() async {
    try {
      final MutationOptions options =
          MutationOptions(document: gql(MultiQuery().login), variables: {
        'email': emailController.text,
        'password': passwordCotroller.text,
      });
      final QueryResult result =
          await MultiQuery().client.value.mutate(options);
      log(result.data.toString());

      // ignore: duplicate_ignore
      if (result.data!['login']['error'] != null) {
        // ignore: use_build_context_synchronously
        showMessanger(context, result.data!['login']['error'].toString());
      } else {
        showMessanger(context, "Login Success!!!");
        checkLogin(result.data!['login']['token'].toString());
        addDevice(result.data!['login']['token'].toString());
        saveUser(
          result.data!['login']['user']['email']['email_str'].toString(),
          result.data!['login']['user']['full_name'].toString(),
          result.data!['login']['user']['password'].toString(),
        );
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
                // settings: RouteSettings(arguments: result.data),
              ),
              (route) => false);
          // getIP();
          getDeviceInfo();
        });
      }
      log(result.data.toString());

      log(result.data!['login']['user']['email']['email_str'].toString());
      log(result.data!['login']['token'].toString());
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? user = _currentUser;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/bgOnBoarding.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: screenHeight * 0.01,
                  child: IconButton(
                    color: whiteColor,
                    iconSize: screenWidth * 0.07,
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  )),
              Positioned(
                top: screenHeight * 0.07,
                left: screenWidth * 0.04,
                child: FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    "Cerdas, Waskit\ndan Militan.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 1200),
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.04,
                          horizontal: screenWidth * 0.04),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Halo!",
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTexField(
                                onPressed: (p0) => setState(() {
                                      // if (emailController.text.isEmpty) {
                                      //   _disableButton = true;
                                      // }
                                      // _disableButton = false;
                                    }),
                                controller: emailController,
                                icon: "assets/icons/envelope.png",
                                hintTextTitle: "Email"),
                            SizedBox(height: screenHeight * 0.02),
                            TextFormField(
                              controller: passwordCotroller,
                              onChanged: (password) {
                                // onPasswordCheck(password);
                                // onCheckDisableButton();
                              },
                              obscureText: !isChecked,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.02,
                                      vertical: screenHeight * 0.01),
                                  child: Image.asset(
                                    "assets/icons/lock.png",
                                    height: screenHeight * 0.03,
                                  ),
                                ),
                                suffixIcon: Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    }),
                                hintText: "Password",
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
                            ),
                            const SizedBox(height: 2),
                            TextButton(
                                onPressed: () {
                                  forgotPassword();
                                },
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Lupa Password?",
                                  ),
                                )),
                            SizedBox(height: screenHeight * 0.02),
                            SizedBox(
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
                                onPressed: () async {
                                  await loginAccount();
                                },
                                child: Text(
                                  "Masuk",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenWidth * 0.04),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "atau masuk dengan",
                              style: TextStyle(
                                color: greyColor,
                                fontSize: screenWidth * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            GestureDetector(
                              onTap: () async {
                                await _handleSignIn();
                                showMessanger(context, "Login Success!!!");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                        settings: RouteSettings(
                                            arguments: user!.displayName)));
                                // await Authentication.signInWithGoogle(
                                //     context: context);
                              },
                              child: Container(
                                height: screenHeight * 0.06,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: blackColor)),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Image.asset(
                                      "assets/icons/google.png",
                                      height: screenHeight * 0.03,
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(
                                      "Google",
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
