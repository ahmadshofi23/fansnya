import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fkbn_flutter/data/ResponseLogin.dart';
import 'package:fkbn_flutter/data/user_model.dart';
import 'package:fkbn_flutter/query/multi_query.dart';
import 'package:fkbn_flutter/screen/user_profile/button.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? imageFile;
  String? data;
  UserModel datas = UserModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonedController = TextEditingController();

  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    data = await prefs.getString('login');
    log(data.toString());
  }

  Future getUser() async {
    final user = await SharedPreferences.getInstance();
    Map<String, dynamic> dataUser = jsonDecode(user.getString("users")!);
    datas = UserModel.fromJson(dataUser);
    log(datas.toString());
    log("email yang di passing");
    log(datas.email.toString());
    log(datas.fullName.toString());
    nameController.text = datas.fullName.toString();
    _emailController.text = datas.email.toString();
    setState(() {});
  }

  Future updateProfile() async {
    try {
      final MutationOptions options = MutationOptions(
          document: gql(MultiQuery().updateProfile),
          variables: {
            'token': data.toString(),
            'email': datas.email.toString(),
            'phoneNumber': _phonedController.text,
            'name': nameController.text,
            'profilePicture': "https://fansnya.com/api" + imageFile.toString(),
          });

      final QueryResult result =
          await MultiQuery().client.value.mutate(options);

      if (result.data!['updateProfile']['message'] != null) {
        log(data.toString());
        log(datas.email.toString());
        log(_phonedController.text);
        log(nameController.text);
        log(imageFile.toString());
        log(result.data!['updateProfile']['message'].toString());
      } else {
        log(result.data!['updateProfile']['message'].toString());
      }
    } catch (e) {}
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    imageFile = File(imagePicked!.path);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    getToken();
    // setTextfield();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidht = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: screenWidht,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.055),
                    Container(
                      height: screenHeight * 0.15,
                      width: screenHeight * 0.15,
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("assets/images/user.png"),
                            ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await getImage();
                      },
                      child: Text(
                        "Ganti Foto",
                        style: TextStyle(
                          fontSize: screenWidht * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidht * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Lengkap",
                      style: TextStyle(
                        fontSize: screenWidht * 0.04,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: screenWidht * 0.04,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      readOnly: true,
                      style: const TextStyle(color: Colors.black),
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      "Nomor HP",
                      style: TextStyle(
                        fontSize: screenWidht * 0.04,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      controller: _phonedController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.24),
                    ButtonProfile(
                        title: "Simpan", press: () => updateProfile()),
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
