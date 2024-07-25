import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class RuteComponent extends StatefulWidget {
  const RuteComponent({Key? key}) : super(key: key);

  @override
  State<RuteComponent> createState() => _RuteComponentState();
}

class _RuteComponentState extends State<RuteComponent> {
  List<dynamic>? datarute;
  Response? response;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    GetDatarute();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                datarute == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: datarute!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return cardrute(datarute![index]);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Ambil data rute
  void GetDatarute() async {
    try {
      response = await dio.get(Getallrute);
      if (response!.statusCode == 200) {
        setState(() {
          // Memastikan respons data adalah list
          datarute = response!.data['data'] as List<dynamic>;
        });
      } else {
        _showErrorDialog(
            context, "Failed to fetch data: ${response!.statusCode}");
      }
    } catch (e) {
      _showErrorDialog(context, "An error occurred: $e");
    }
  }

  Widget cardrute(dynamic rute) {
    String? namaBus;

    // Ambil ID bus dari objek data
    String busId = rute['bus'];

    // Cari objek bus yang sesuai dengan ID tersebut
    // Perhatikan bahwa Anda mungkin perlu request tambahan untuk mendapatkan data bus secara terpisah
    Map<String, dynamic>? bus =
        datarute?.firstWhere((bus) => bus['_id'] == busId, orElse: () => null);

    // Jika objek bus ditemukan, ambil nama busnya
    if (bus != null) {
      namaBus = bus['nama'];
    }

    return GestureDetector(
      onTap: () {
        // Add your onTap functionality here
      },
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        right:
                            BorderSide(width: 1.0, color: Colors.grey.shade300),
                      ),
                    ),
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/128/2684/2684211.png",
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rute: ${rute['namarute']}",
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Asal: ${rute['asal']}",
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Tujuan: ${rute['tujuan']}",
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Jarak: ${rute['jarak']}",
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: mTitleColor,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }
}
