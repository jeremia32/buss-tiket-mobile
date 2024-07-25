import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/components/custum_surfix_icon.dart';
import 'package:bus_tiket/components/default_button_custome_color.dart';
import 'package:bus_tiket/srceens/admin/homeAdminScreen.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Forminputbus extends StatefulWidget {
  @override
  _Forminputbus createState() => _Forminputbus();
}

class _Forminputbus extends State<Forminputbus> {
  TextEditingController txtNamabus = TextEditingController();
  TextEditingController txttipebus = TextEditingController();
  TextEditingController txtNomorbus = TextEditingController();
  TextEditingController txtdeskripsi = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNodeNamaBus = FocusNode();
  FocusNode focusNodeHargaBus = FocusNode(); // FocusNode untuk Harga Bus
  FocusNode focusNodeDeskripsiBus =
      FocusNode(); // FocusNode untuk Deskripsi Bus
  Response? response;
  var dio = Dio();
  dynamic image; // Menggunakan tipe data dinamis untuk mendukung Flutter Web
  // List pilihan tipe bus
  List<String> tipeBusOptions = [
    'Pilih Tipe Bus',
    'Execitive',
    'Ekonomi ',
  ];
  String selectedTipeBus = 'Pilih Tipe Bus';

  @override
  void dispose() {
    // Hapus focusNode saat widget dihapus
    focusNodeNamaBus.dispose();
    focusNodeHargaBus.dispose();
    focusNodeDeskripsiBus.dispose();
    txttipebus.dispose(); // Hapus objek saat widget dihapus

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildUserName(),
          SizedBox(height: 30),
          buildTipeBusDropdown(), // Menggunakan DropdownButtonFormField untuk tipe bus
          SizedBox(height: 30),
          buildhargabus(),
          SizedBox(height: 30),
          builddeskripsi(),
          SizedBox(height: 30),
          buildImageWidget(),
          SizedBox(height: 30),
          DefaultButtonCustomeColor(
            color: Color.fromARGB(255, 9, 199, 104),
            text: "Pilih Gambar",
            press: () {
              piligambar();
            },
          ),
          SizedBox(height: 30),
          DefaultButtonCustomeColor(
            color: Colors.blue,
            text: "Tambahkan",
            press: () {
              validateAndSubmit();
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  // Method untuk menampilkan pesan kesalahan
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

  // Validasi dan kirim data ke backend
  void validateAndSubmit() {
    if (txtNamabus.text.isEmpty) {
      showErrorMessage('Nama Bus');
      return;
    }
    if (selectedTipeBus == 'Pilih Tipe Bus') {
      showErrorMessage('Tipe Bus');
      return;
    }
    if (txtNomorbus.text.isEmpty) {
      showErrorMessage('Nomor Bus');
      return;
    }
    if (txtdeskripsi.text.isEmpty) {
      showErrorMessage('Deskripsi Bus');
      return;
    }
    if (image == null) {
      showErrorMessage('Gambar Bus');
      return;
    }

    inputDatabus(txtNamabus.text, selectedTipeBus, txtNomorbus.text,
        txtdeskripsi.text, image);
  }

  // buat style nya
  TextFormField buildUserName() {
    return TextFormField(
      controller: txtNamabus,
      keyboardType: TextInputType.text,
      focusNode: focusNodeNamaBus, // Terapkan focusNode ke TextFormField
      decoration: InputDecoration(
        labelText: 'Nama Bus',
        hintText: 'Masukkan nama Bus',
        labelStyle: TextStyle(
          color: focusNodeNamaBus.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/bus.svg",
        ),
      ),
    );
  }

  // DropdownButtonFormField untuk tipe bus
  DropdownButtonFormField<String> buildTipeBusDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedTipeBus,
      items: tipeBusOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: 'Tipe Bus',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/bus.svg",
        ),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedTipeBus = newValue!;
        });
      },
    );
  }

  // harga
  TextFormField buildhargabus() {
    return TextFormField(
      controller: txtNomorbus,
      keyboardType: TextInputType.text,
      focusNode: focusNodeHargaBus, // Terapkan focusNode ke TextFormField
      decoration: InputDecoration(
        labelText: 'Nomor Bus',
        hintText: 'Masukkan nomor Bus',
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/bus.svg",
        ),
      ),
    );
  }

  // deskripsi bus
  TextFormField builddeskripsi() {
    return TextFormField(
      controller: txtdeskripsi,
      keyboardType: TextInputType.text,
      focusNode: focusNodeDeskripsiBus, // Terapkan focusNode ke TextFormField
      decoration: InputDecoration(
        labelText: 'Deskripsi Bus',
        hintText: 'Masukkan deskripsi Bus',
        labelStyle: TextStyle(
          color: focusNodeDeskripsiBus.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/bus.svg",
        ),
      ),
    );
  }

// web
  Widget buildImageWidget() {
    return image != null
        ? Image.network(
            image, // URL gambar dari cache lokal
            width: 250,
            height: 250,
          )
        : Container(); // Jika gambar tidak dipilih, tampilkan Container kosong
  }

// Memilih gambar dari galeri
  // Memilih gambar dari galeri
  Future<void> piligambar() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      setState(() {
        image = pickedImage.path; // Simpan path gambar yang dipilih
      });
    } catch (e) {
      print("Gagal mengambil gambar: $e");
    }
  }

// mobile
// Memilih gambar dari galeri
//   Future<void> piligambar() async {
//     try {
//       final pickedImage =
//           await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedImage == null) return;

//       setState(() {
//         image = pickedImage; // Simpan objek PickedFile yang dipilih
//       });
//     } catch (e) {
//       print("Gagal mengambil gambar: $e");
//     }
//   }

// // Widget untuk menampilkan gambar yang dipilih
//   Widget buildImageWidget() {
//     return image != null
//         ? Image.file(
//             File(image.path),
//             width: 250,
//             height: 250,
//           )
//         : Container(); // Jika gambar tidak dipilih, tampilkan Container kosong
//   }

  // Mengirim data bus ke backend
  void inputDatabus(
    String nama,
    String tipe,
    String nomormobil,
    String deskripsi,
    dynamic gambar, // Menggunakan tipe File dari dart:io
    // mobile nya
    // XFile gambar, // Menggunakan tipe XFile dari package image_picker
  ) async {
    print('Mengirim data bus ke backend:');
    print('Nama: $nama');
    print('Tipe: $tipe');
    print('Nomor Mobil: $nomormobil');
    print('Deskripsi: $deskripsi');
    print('Gambar: $gambar'); // Path file gambar

    utilApps.showDialog(context);
    bool status;
    var msg;
    try {
      var responseImage = await http.get(Uri.parse(gambar));
      var imageBytes = responseImage.bodyBytes;

      FormData formData = FormData.fromMap({
        'nama': nama,
        'tipe': tipe,
        'nomormobil': nomormobil,
        'deskripsi': deskripsi,
// web
        'gambar': MultipartFile.fromBytes(
          imageBytes,
          filename: 'gambar.jpg',
        ),

        // mobile

        // 'gambar':
        //     await MultipartFile.fromFile(gambar.path, filename: 'gambar.jpg'),
      });

      Response response = await dio.post(Inputbus, data: formData);

      status = response.data['sukses'];
      msg = response.data['msg'];

      if (status) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Peringatan',
          desc: '$msg',
          btnOkOnPress: () {
            print('Dialog ditutup, navigasi ke HomeAdminScreen');
            Navigator.of(context, rootNavigator: true).pop(); // Menutup dialog
            Future.delayed(Duration(milliseconds: 300), () {
              print('Navigasi ke HomeAdminScreen');
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
