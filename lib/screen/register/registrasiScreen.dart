import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:fkbn_flutter/data/ResponseLogin.dart';
import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/screen/login/loginScreen.dart';
import 'package:fkbn_flutter/screen/register/componentRegistrasi/customeTexfield.dart';
import 'package:fkbn_flutter/screen/verifikasi/sendVerifikasiPage.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RegistrasiScreen extends StatefulWidget {
  RegistrasiScreen({Key? key}) : super(key: key);

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  bool isChecked = false;
  bool _isPasswordEightCharacter = false;
  bool _isPasswordhasNumber = false;
  bool _disableButton = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordCotroller = TextEditingController();

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

  void clearTextField() {
    nameController.clear();
    passwordCotroller.clear();
    emailController.clear();
  }

  onCheckDisableButton() {
    setState(() {
      if (nameController.text.isNotEmpty) {
        if (emailController.text.isNotEmpty) {
          _disableButton = true;
          if (_isPasswordEightCharacter == true &&
              _isPasswordhasNumber == true) {
            _disableButton = false;
          }
        }
      }
    });
  }

  Future showMessanger(BuildContext context, String message) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future registrasiAccount() async {
    try {
      "User validation failed: email.email_str: Validator failed for path `email.email_str` with value `ahmadshofihasibuan1323gmail.com`";
      final MutationOptions options = MutationOptions(
          document: gql(MultiQuery().registerAccount),
          variables: {
            'fullName': nameController.text,
            'email': emailController.text,
            'password': passwordCotroller.text,
          });
      final QueryResult result =
          await MultiQuery().client.value.mutate(options);
      if (result.data!['register']['error'] != null) {
        showMessanger(context, result.data!['register']['error'].toString());
      } else {
        showMessanger(context, "Register Success!!!!");
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SendVerificationPage(),
              settings: RouteSettings(
                arguments: result.data!['register']['user']['email']
                        ['email_str']
                    .toString(),
              ),
            ),
          );
          clearTextField();
        });
      }
      log(result.data.toString());
      // log(result.data!['login']['user']['email']['email_str'].toString());
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
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
                    icon: Icon(Icons.arrow_back),
                  )),
              Positioned(
                top: screenHeight * 0.07,
                left: screenWidth * 0.04,
                child: FadeInUp(
                  duration: Duration(milliseconds: 1000),
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
                  delay: Duration(milliseconds: 700),
                  duration: Duration(milliseconds: 1200),
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.04,
                          horizontal: screenWidth * 0.04),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Datang!",
                              style: TextStyle(
                                color: blackColor,
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            CustomTexField(
                                onPressed: ((p0) {}),
                                controller: nameController,
                                icon: "assets/icons/user.png",
                                hintTextTitle: "Nama Lengkap"),
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
                                onPasswordCheck(password);
                                // onCheckDisableButton();
                              },
                              obscureText: !isChecked,
                              decoration: InputDecoration(
                                prefixIcon: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02,
                                        vertical: screenHeight * 0.01),
                                    child: Image.asset(
                                      "assets/icons/lock.png",
                                      height: screenHeight * 0.03,
                                    ),
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
                            SizedBox(height: 2),
                            Text(
                              "Minimal 8 Kareakter dengan huruf besar dan angka",
                              style: TextStyle(
                                color: _isPasswordEightCharacter &&
                                        _isPasswordhasNumber
                                    ? blackColor
                                    : Colors.red,
                                fontSize: screenWidth * 0.03,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            SizedBox(
                              height: screenHeight * 0.06,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: _disableButton
                                        ? primaryColor.withOpacity(0.5)
                                        : primaryColor,
                                    shadowColor: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    )),
                                onPressed: _disableButton
                                    ? null
                                    : () async {
                                        await registrasiAccount();
                                      },
                                child: Text(
                                  "Buat Akun",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: screenWidth * 0.04),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Sudah punya akun?",
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ));
                                    clearTextField();
                                  },
                                  child: Text(
                                    "Masuk disini",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04),
                              child: Text(
                                "Dengan membuat akun saya telah setuju dengan Syarat & Ketentuan serta Kebijakan Privasi yang diterapkan oleh Fansnya FKBN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
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
