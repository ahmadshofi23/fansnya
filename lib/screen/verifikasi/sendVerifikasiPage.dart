import 'package:animate_do/animate_do.dart';
import 'package:fkbn_flutter/data/ResponseLogin.dart';
import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/screen/login/loginScreen.dart';
import 'package:fkbn_flutter/screen/verifikasi/componentVerfifikasiScreen/numericPadPage.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SendVerificationPage extends StatefulWidget {
  SendVerificationPage({Key? key, this.phoneNumber}) : super(key: key);
  final String? phoneNumber;

  @override
  State<SendVerificationPage> createState() => _SendVerificationPageState();
}

class _SendVerificationPageState extends State<SendVerificationPage> {
  String code = "";
  String email = "";

  Future showMessanger(BuildContext context, String message) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future sendPin() async {
    try {
      final MutationOptions options =
          MutationOptions(document: gql(MultiQuery().sendPin), variables: {
        'email': email,
      });
      final QueryResult result =
          await MultiQuery().client.value.mutate(options);
      showMessanger(context, result.data!['sendPin']['message'].toString());
      print(result.data!['sendPin']['message']);
    } catch (err) {
      print(err.toString());
    }
  }

  Future verifikasiPin() async {
    try {
      final MutationOptions options = MutationOptions(
          document: gql(MultiQuery().verifikasiPin),
          variables: {
            'email': email,
            'pin': code,
          });
      print(code);
      final QueryResult result =
          await MultiQuery().client.value.mutate(options);

      if (result.data!['verifikasiPin']['message'] != null) {
        showMessanger(
            context, result.data!['verifikasiPin']['message'].toString());

        Future.delayed(
          Duration(seconds: 2),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen())),
        );
      } else {
        showMessanger(
            context, result.data!['verifikasiPin']['error'].toString());
      }
    } catch (err) {
      // showMessanger(context, "User not found");
      print(err.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print("Ini Di Jalankan di awal");
    Future.delayed(
      Duration(seconds: 2),
      () {
        print("Pin dikirm");
        sendPin();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments.toString();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 10,
              left: 20,
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
                  height: MediaQuery.of(context).size.height * 0.75,
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
                          "Masukkan Kode Verifikasi dari Email",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: screenWidth * 0.065,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.016),
                        Text(
                          "Kode verifikasi telah dikirim ke email",
                          style: TextStyle(
                            color: greyColor,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildCodeNumberBox(
                                  code.length > 0 ? code.substring(0, 1) : ""),
                              buildCodeNumberBox(
                                  code.length > 1 ? code.substring(1, 2) : ""),
                              buildCodeNumberBox(
                                  code.length > 2 ? code.substring(2, 3) : ""),
                              buildCodeNumberBox(
                                  code.length > 3 ? code.substring(3, 4) : ""),
                              buildCodeNumberBox(
                                  code.length > 4 ? code.substring(4, 5) : ""),
                              buildCodeNumberBox(
                                  code.length > 5 ? code.substring(5, 6) : ""),
                            ],
                          ),
                        ),
                        NumericPad(onNumberSelected: (value) {
                          setState(() {
                            if (value != -1) {
                              if (code.length < 6) {
                                code = code + value.toString();
                              }
                            } else {
                              code = code.substring(0, code.length - 1);
                            }
                            print(code);
                          });
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Kode tidak diterima?"),
                            TextButton(
                              onPressed: () async {
                                await sendPin();
                              },
                              child: Text(
                                "Kirim Ulang",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontWeight: FontWeight.w700,
                                    color: secondColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  // side: BorderSide(
                                  //     color: _disableButton
                                  //         ? greyColor
                                  //         : primaryColor,
                                  //     width: 2),
                                  borderRadius: BorderRadius.circular(28),
                                )),
                            onPressed: () async {
                              await verifikasiPin();
                            },
                            child: Text(
                              "Konfirmasi",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: screenWidth * 0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            color: greyColor.withOpacity(0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
