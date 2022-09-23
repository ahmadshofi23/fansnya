import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isChecked = false;
  bool isChekedPasswordNew = false;
  bool isChekedPasswordConfirm = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: blackColor)),
        title: Text(
          "Keamanan Akun",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: blackColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Ubah Password",
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                "Masukkan password anda",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                // controller: passwordCotroller,
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
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Buat password baru",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                // controller: passwordCotroller,
                onChanged: (password) {
                  // onPasswordCheck(password);
                  // onCheckDisableButton();
                },
                obscureText: !isChekedPasswordNew,
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
                      value: isChekedPasswordNew,
                      onChanged: (value) {
                        setState(() {
                          isChekedPasswordNew = value!;
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
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Ketik ulang password baru",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackColor,
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextFormField(
                // controller: passwordCotroller,
                onChanged: (password) {
                  // onPasswordCheck(password);
                  // onCheckDisableButton();
                },
                obscureText: !isChekedPasswordConfirm,
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
                      value: isChekedPasswordConfirm,
                      onChanged: (value) {
                        setState(() {
                          isChekedPasswordConfirm = value!;
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
                  onPressed: () async {},
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                        color: whiteColor, fontSize: screenWidth * 0.04),
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
