import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fkbn_flutter/data/provinsi_model.dart';
import 'package:fkbn_flutter/screen/user_profile/button.dart';
import 'package:fkbn_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DataDiriScreen extends StatefulWidget {
  DataDiriScreen({Key? key}) : super(key: key);

  @override
  State<DataDiriScreen> createState() => _DataDiriScreenState();
}

class _DataDiriScreenState extends State<DataDiriScreen> {
  TextEditingController nikController = TextEditingController();
  TextEditingController tanggalBergabung = TextEditingController();
  TextEditingController tanggalLahir = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController profesiController = TextEditingController();
  List _itemProvinsi = [];
  List _itemKota = [];
  List _itemKecamatan = [];
  List _itemKelurahan = [];
  bool checkBOx = false;
  int? isChecked;
  int idProvinsi = 100;
  int idKabupaten = 0;
  int idKecamatan = 0;
  String defaultProvinsi = "";
  String defaultKota = "";
  String defaultKecamatan = "";
  String defaultKelurahan = "";

  Future<void> readProvinsiFromJson() async {
    final String response =
        await rootBundle.loadString("assets/data/provinsi.json");
    final data = await json.decode(response);
    setState(() {
      _itemProvinsi = data;
    });
  }

  Future<void> readKotaFromJson(int id) async {
    final String response =
        await rootBundle.loadString("assets/data/kabupaten/$id.json");
    final data = await json.decode(response);
    setState(() {
      _itemKota = data;
    });
  }

  Future<void> readKecamatanFromJson(int id) async {
    final String response =
        await rootBundle.loadString("assets/data/kecamatan/$id.json");
    final data = await json.decode(response);
    setState(() {
      _itemKecamatan = data;
    });
  }

  Future<void> readKelurahanFromJson(int id) async {
    final String response =
        await rootBundle.loadString("assets/data/kelurahan/$id.json");
    final data = await json.decode(response);
    setState(() {
      _itemKelurahan = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    tanggalBergabung.text = "";
    tanggalLahir.text = "";
    defaultKelurahan = "Pilih";
    defaultKecamatan = "Pilih";
    defaultKota = "Pilih";
    defaultProvinsi = "Pilih";
    super.initState();
  }

  void saveData() {
    log(defaultKecamatan);
    log(tanggalLahir.text);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.032,
        vertical: screenHeight * 0.039,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nomor Induk Kependudukan",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: nikController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal Bergabung",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: tanggalBergabung,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));
                        if (pickedDate != null) {
                          log(pickedDate.toString());
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          log(formattedDate);
                          setState(() {
                            tanggalBergabung.text = formattedDate;
                          });
                        } else {
                          log("Date is not selected");
                        }
                      },
                      child: Icon(
                        Icons.date_range_outlined,
                        color: blackColor,
                        size: screenHeight * 0.03,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tempat Lahir",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: tempatLahirController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tanggal Lahir",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: tanggalLahir,
                  decoration: InputDecoration(
                    hintText: "DD-MM-YYYY",
                    suffixIcon: InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1000),
                            lastDate: DateTime(3000));
                        if (pickedDate != null) {
                          log(pickedDate.toString());
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          log(formattedDate);
                          setState(() {
                            tanggalLahir.text = formattedDate;
                          });
                        } else {
                          log("Date is not selected");
                        }
                      },
                      child: Icon(
                        Icons.date_range_outlined,
                        color: blackColor,
                        size: screenHeight * 0.03,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profesi",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  controller: profesiController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            "Alamat (sesuai domisili)",
            style: TextStyle(
              color: blackColor,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Provinsi",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Text(
                    defaultProvinsi,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  InkWell(
                      onTap: () async {
                        await readProvinsiFromJson();

                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            context: context,
                            builder: (contex) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.18),
                                      child: Text(
                                        "Pilih Provinsi",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: screenWidth * 0.06),
                                      ),
                                    ),
                                    leading: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Icon(
                                        Icons.close,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _itemProvinsi.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.04,
                                            vertical: screenHeight * 0.01),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              defaultProvinsi =
                                                  _itemProvinsi[index]['nama']
                                                      .toString();
                                              isChecked = index;
                                              var idProv = int.parse(
                                                  _itemProvinsi[index]['id']);
                                              idProvinsi = idProv;
                                              log(isChecked.toString());
                                            });
                                            Timer(
                                              Duration(seconds: 1),
                                              () => Navigator.pop(context),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _itemProvinsi[index]['nama'],
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.04),
                                              ),
                                              Radio(
                                                value: index,
                                                groupValue: isChecked,
                                                onChanged: (val) {
                                                  setState(() {
                                                    defaultProvinsi =
                                                        _itemProvinsi[index]
                                                                ['nama']
                                                            .toString();
                                                    var idProv = int.parse(
                                                        _itemProvinsi[index]
                                                            ['id']);
                                                    idProvinsi = idProv;
                                                    isChecked = index;
                                                    log(isChecked.toString());
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Icon(Icons.arrow_forward_ios_rounded))
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kota",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Text(
                    defaultKota,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  InkWell(
                      onTap: () async {
                        await readKotaFromJson(idProvinsi);
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            context: context,
                            builder: (contex) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.18),
                                      child: Text(
                                        "Pilih Kota",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: screenWidth * 0.06),
                                      ),
                                    ),
                                    leading: InkWell(
                                      onTap: () => Navigator.pop(context),
                                      child: Icon(
                                        Icons.close,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _itemKota.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.04,
                                            vertical: screenHeight * 0.01),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              defaultKota = _itemKota[index]
                                                      ['nama']
                                                  .toString();
                                              isChecked = index;
                                              idKabupaten = int.parse(
                                                  _itemKota[index]['id']
                                                      .toString());
                                              log(_itemKota[index]['id']
                                                  .toString());
                                              log(isChecked.toString());
                                            });
                                            Timer(
                                              Duration(seconds: 1),
                                              () => Navigator.pop(context),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                _itemKota[index]['nama'],
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.04),
                                              ),
                                              Radio(
                                                value: index,
                                                groupValue: isChecked,
                                                onChanged: (val) {
                                                  setState(() {
                                                    defaultKota =
                                                        _itemKota[index]['nama']
                                                            .toString();
                                                    idKabupaten = int.parse(
                                                        _itemKota[index]['id']
                                                            .toString());
                                                    isChecked = index;
                                                    log(isChecked.toString());
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Icon(Icons.arrow_forward_ios_rounded)),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kecamatan",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: () async {
                  await readKecamatanFromJson(idKabupaten);
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      context: context,
                      builder: (contex) {
                        return Column(
                          children: [
                            ListTile(
                              title: Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.18),
                                child: Text(
                                  "Pilih Kota",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.06),
                                ),
                              ),
                              leading: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.close,
                                  color: blackColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _itemKecamatan.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04,
                                      vertical: screenHeight * 0.01),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        defaultKecamatan = _itemKecamatan[index]
                                                ['nama']
                                            .toString();
                                        idKecamatan = int.parse(
                                            _itemKecamatan[index]['id']
                                                .toString());
                                        isChecked = index;
                                        log(isChecked.toString());
                                      });
                                      Timer(
                                        Duration(seconds: 1),
                                        () => Navigator.pop(context),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _itemKecamatan[index]['nama'],
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04),
                                        ),
                                        Radio(
                                          value: index,
                                          groupValue: isChecked,
                                          onChanged: (val) {
                                            setState(() {
                                              defaultKecamatan =
                                                  _itemKecamatan[index]['nama']
                                                      .toString();
                                              idKecamatan = int.parse(
                                                  _itemKecamatan[index]['id']
                                                      .toString());
                                              isChecked = index;
                                              log(isChecked.toString());
                                            });
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Row(
                  children: [
                    Text(
                      defaultKecamatan,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kelurahan",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
              InkWell(
                onTap: () async {
                  await readKelurahanFromJson(idKecamatan);
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      context: context,
                      builder: (contex) {
                        return Column(
                          children: [
                            ListTile(
                              title: Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.18),
                                child: Text(
                                  "Pilih Kota",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.06),
                                ),
                              ),
                              leading: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.close,
                                  color: blackColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _itemKelurahan.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04,
                                      vertical: screenHeight * 0.01),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        defaultKelurahan = _itemKelurahan[index]
                                                ['nama']
                                            .toString();

                                        isChecked = index;
                                        log(isChecked.toString());
                                      });
                                      Timer(
                                        Duration(seconds: 1),
                                        () => Navigator.pop(context),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _itemKelurahan[index]['nama'],
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.04),
                                        ),
                                        Radio(
                                          value: index,
                                          groupValue: isChecked,
                                          onChanged: (val) {
                                            setState(() {
                                              defaultKelurahan =
                                                  _itemKelurahan[index]['nama']
                                                      .toString();
                                              isChecked = index;
                                              log(isChecked.toString());
                                            });
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Row(
                  children: [
                    Text(
                      defaultKelurahan,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Icon(Icons.arrow_forward_ios_rounded),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RT / RW",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.4,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kode Pos",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.4,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "Alamat (sesuai domisili)",
            style: TextStyle(
              color: blackColor,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          TextFormField(
            maxLines: 6,
            minLines: 6,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            children: [
              Checkbox(value: checkBOx, onChanged: (value) {}),
              Text(
                "Alamat Domisili sesuai dengan Alamat KTP",
                style: TextStyle(
                  color: blackColor,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          ButtonProfile(
            title: "Simpan",
            press: () {
              saveData();
            },
          )
        ],
      ),
    );
  }
}
