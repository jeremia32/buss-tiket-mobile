import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/components/custum_surfix_icon.dart';
import 'package:bus_tiket/components/default_button_custome_color.dart';
import 'package:bus_tiket/srceens/admin/homeAdminScreen.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Forminputrute extends StatefulWidget {
  @override
  _Forminputrute createState() => _Forminputrute();
}

class _Forminputrute extends State<Forminputrute> {
  TextEditingController txtasal = TextEditingController();
  TextEditingController txtnamarute = TextEditingController();
  TextEditingController txttujuan = TextEditingController();
  TextEditingController txtJarak = TextEditingController();
  TextEditingController txtdurasi = TextEditingController();
  FocusNode focusNodeBus = FocusNode();
  FocusNode focusNodeasal = FocusNode();
  FocusNode focusNodetujuan = FocusNode();
  FocusNode focusNodejarak = FocusNode();
  FocusNode focusNodedurasi = FocusNode();
  FocusNode focusNodenamarute = FocusNode();
  Response? response;
  var dio = Dio();

  List<dynamic> busList = [];
  String? selectedBusId;

  @override
  void initState() {
    fetchBusList();
    super.initState();
  }

  Future<void> fetchBusList() async {
    try {
      Response response = await dio.get(Getallbus);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['sukses'] == true) {
          setState(() {
            busList = responseData['data'];
          });
        } else {
          print('Failed to load bus list: ${responseData['message']}');
        }
      } else {
        print('Failed to load bus list');
      }
    } catch (e) {
      print('Error fetching bus list: $e');
    }
  }

  @override
  void dispose() {
    focusNodeBus.dispose();
    focusNodeasal.dispose();
    focusNodetujuan.dispose();
    focusNodedurasi.dispose();
    focusNodenamarute.dispose();
    focusNodejarak.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildBusDropdown(),
          SizedBox(height: 30),
          buildnamarute(),
          SizedBox(height: 30),
          buildasal(),
          SizedBox(height: 30),
          buildtujuan(),
          SizedBox(height: 30),
          builddurasi(),
          SizedBox(height: 30),
          buildjarak(),
          SizedBox(height: 30),
          DefaultButtonCustomeColor(
            color: Colors.blue,
            text: "Tambahkan",
            press: () {
              validateAndSubmit();
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void showErrorMessage(String field) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Peringatan',
      desc: '$field tidak boleh kosong',
      btnOkOnPress: () {},
    ).show();
  }

  void validateAndSubmit() {
    if (selectedBusId == null) {
      showErrorMessage('Nama Bus');
      return;
    }
    if (txtasal.text.isEmpty) {
      showErrorMessage('Asal');
      return;
    }
    if (txtnamarute.text.isEmpty) {
      showErrorMessage('namarute');
      return;
    }
    if (txttujuan.text.isEmpty) {
      showErrorMessage('Tujuan');
      return;
    }
    if (txtJarak.text.isEmpty) {
      showErrorMessage('Jarak');
      return;
    }
    if (txtdurasi.text.isEmpty) {
      showErrorMessage('Durasi');
      return;
    }

    inputDatarute(selectedBusId!, txtnamarute.text, txtasal.text,
        txttujuan.text, txtJarak.text, txtdurasi.text);
  }

  DropdownButtonFormField<String> buildBusDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedBusId,
      items: busList.map<DropdownMenuItem<String>>((bus) {
        return DropdownMenuItem<String>(
          value: bus['_id'],
          child: Text(bus['nama']),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedBusId = newValue;
        });
      },
      decoration: InputDecoration(
        labelText: 'Nama Bus',
        hintText: 'Pilih nama Bus',
        labelStyle: TextStyle(
          color: focusNodeBus.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/bus.svg",
        ),
      ),
    );
  }

  TextFormField buildasal() {
    return TextFormField(
      controller: txtasal,
      keyboardType: TextInputType.text,
      focusNode: focusNodeasal,
      decoration: InputDecoration(
        labelText: 'Asal',
        hintText: 'Masukkan asal',
        labelStyle: TextStyle(
          color: focusNodeasal.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/rute.svg",
        ),
      ),
    );
  }

  TextFormField buildnamarute() {
    return TextFormField(
      controller: txtnamarute,
      keyboardType: TextInputType.text,
      focusNode: focusNodenamarute,
      decoration: InputDecoration(
        labelText: 'nama Rute',
        hintText: 'Masukkan Nama Rute',
        labelStyle: TextStyle(
          color: focusNodenamarute.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/rute.svg",
        ),
      ),
    );
  }

  TextFormField buildtujuan() {
    return TextFormField(
      controller: txttujuan,
      keyboardType: TextInputType.text,
      focusNode: focusNodetujuan,
      decoration: InputDecoration(
        labelText: 'Tujuan',
        hintText: 'Masukkan tujuan',
        labelStyle: TextStyle(
          color: focusNodetujuan.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/rute.svg",
        ),
      ),
    );
  }

  TextFormField builddurasi() {
    return TextFormField(
      controller: txtdurasi,
      keyboardType: TextInputType.number,
      focusNode: focusNodedurasi,
      decoration: InputDecoration(
        labelText: 'Durasi',
        hintText: 'Masukkan durasi',
        labelStyle: TextStyle(
          color: focusNodedurasi.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/clock.svg",
        ),
      ),
    );
  }

  TextFormField buildjarak() {
    return TextFormField(
      controller: txtJarak,
      keyboardType: TextInputType.number,
      focusNode: focusNodejarak,
      decoration: InputDecoration(
        labelText: 'Jarak',
        hintText: 'Masukkan jarak',
        labelStyle: TextStyle(
          color: focusNodejarak.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/jarak.svg",
        ),
      ),
    );
  }

  void inputDatarute(String bus, String namarute, String asal, String tujuan,
      String jarak, String durasi) async {
    print('data di masukkan ');

    print('bus: $bus');
    print('bus: $namarute');
    print('Asal: $asal');
    print('Tujuan: $tujuan');
    print('Jarak: $jarak');
    print('Durasi: $durasi');

    utilApps.showDialog(context);
    bool status;
    var msg;
    try {
      Map<String, dynamic> formData = {
        'bus': bus,
        'namarute': namarute,
        'asal': asal,
        'tujuan': tujuan,
        'jarak': jarak, // Sudah dalam bentuk String
        'durasi': durasi, // Sudah dalam bentuk String
      };
      print('Data yang dikirim: $formData');

      Response response = await dio.post(
        Inputrute,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Mengatur header
          },
        ),
      );

      // Log untuk melihat respons dari server
      print('Respons dari server: ${response.data}');

      status = response.data['sukses'];
      msg = response.data['msg'];

      if (status) {
        print(status);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Peringatan',
          desc: '$msg',
          btnOkOnPress: () {
            Navigator.of(context, rootNavigator: true).pop();
            Future.delayed(Duration(milliseconds: 300), () {
              Navigator.pushNamed(context, HomeAdminScreen.routeName);
            });
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Peringatan',
          desc: '$msg',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Terjadi kesalahan pada server kami !!.... ',
        desc: '$msg',
        btnOkOnPress: () {
          utilApps.hideDialog(context);
        },
      ).show();
    }
  }
}
