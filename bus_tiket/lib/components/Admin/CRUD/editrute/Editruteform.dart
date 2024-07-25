import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/components/custum_surfix_icon.dart';
import 'package:bus_tiket/components/default_button_custome_color.dart';
import 'package:bus_tiket/srceens/admin/CRUD/EditruteScreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/editBusSreen.dart';
import 'package:bus_tiket/srceens/admin/homeAdminScreen.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Formeditrute extends StatefulWidget {
  @override
  _Formeditrute createState() => _Formeditrute();
}

class _Formeditrute extends State<Formeditrute> {
  TextEditingController txtasal =
      TextEditingController(text: '${EditruteSreens.datarute['asal']}');
  TextEditingController txtnamarute =
      TextEditingController(text: '${EditruteSreens.datarute['namarute']}');
  TextEditingController txttujuan =
      TextEditingController(text: '${EditruteSreens.datarute['tujuan']}');
  TextEditingController txtJarak =
      TextEditingController(text: '${EditruteSreens.datarute['jarak']}');
  TextEditingController txtdurasi =
      TextEditingController(text: '${EditruteSreens.datarute['durasi']}');
  FocusNode focusNodeBus = FocusNode();
  FocusNode focusNodeasal = FocusNode();
  FocusNode focusNodenamarute = FocusNode();
  FocusNode focusNodetujuan = FocusNode();
  FocusNode focusNodejarak = FocusNode();
  FocusNode focusNodedurasi = FocusNode();
  Response? response;
  var dio = Dio();
  List<dynamic> busList = [];
  String? selectedBusId;
  @override
  void dispose() {
    focusNodeBus.dispose();
    focusNodeasal.dispose();
    focusNodenamarute.dispose();
    focusNodetujuan.dispose();
    focusNodedurasi.dispose();
    focusNodejarak.dispose();
    super.dispose();
  }

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
            text: "Simpan",
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

    editDatarute(selectedBusId!, txtnamarute.text, txtasal.text, txttujuan.text,
        txtJarak.text, txtdurasi.text);
  }

  // buat style nya
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
          svgIcon: "asset/icons/bus.svg",
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
        labelText: 'nama rute',
        hintText: 'Masukkan nama rute',
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
          svgIcon: "asset/icons/bus.svg",
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
          svgIcon: "asset/icons/bus.svg",
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
          svgIcon: "asset/icons/bus.svg",
        ),
      ),
    );
  }

  // Mengirim data bus ke backend
  void editDatarute(String bus, String namarute, String asal, String tujuan,
      String jarak, String durasi) async {
    print('Mengirim data rute ke backend:');
    print('Data yang dimasukkan:');
    print('bus: $bus');
    print('namarute: $namarute');
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
        'jarak': jarak,
        'durasi': durasi,
      };

      // Panggilan HTTP PUT menggunakan dio
      Response response = await dio.put(
        // Ganti Editrute dengan URL endpoint Anda untuk mengedit rute berdasarkan ID
        '$Editrute/${EditruteSreens.datarute['_id']}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        // Kirim data dalam bentuk JSON
        data: formData,
      );

      // Log respons dari server
      print('Respons dari server: ${response.data}');

      // Tanggapi respons dari server
      status = response.data['sukses'];
      msg = response.data['msg'];
      if (status) {
        print(status);
        // Tampilkan dialog sukses jika berhasil
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
        // Tampilkan dialog error jika gagal
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
      // Tampilkan dialog error jika terjadi kesalahan
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
