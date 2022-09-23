import 'package:fkbn_flutter/screen/register/componentRegistrasi/customeTexfield.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegistrasScreen extends StatefulWidget {
  RegistrasScreen({Key? key}) : super(key: key);

  @override
  State<RegistrasScreen> createState() => _RegistrasScreenState();
}

class _RegistrasScreenState extends State<RegistrasScreen> {
  bool isChecked = false;
  bool showPass = true;

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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 10,
              left: 20,
              child: Text(
                "Cerdas, Waskit\ndan Militan.",
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  color: whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
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
                          icon: "assets/icons/user.png",
                          hintTextTitle: "Nama Lengkap"),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTexField(
                          icon: "assets/icons/envelope.png",
                          hintTextTitle: "Email"),
                      SizedBox(height: screenHeight * 0.02),
                      TextFormField(
                        obscureText: showPass,
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
                                  if (isChecked == true) {
                                    showPass = false;
                                  } else {
                                    showPass = true;
                                  }
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
                      Text(
                        "Minimal 8 Kareakter dengan huruf besar dan angka",
                        style: TextStyle(
                          color: greyColor,
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(
                        height: screenHeight * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(28),
                              )),
                          onPressed: () {},
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
                            onPressed: () {},
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
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
