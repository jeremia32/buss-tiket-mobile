import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/components/default_button_custome_color.dart';
import 'package:bus_tiket/srceens/user/Transaksi/TransaksiScreen.dart';
import 'package:bus_tiket/srceens/user/bayar/BayarScreen.dart';
import 'package:bus_tiket/srceens/user/homeUserScreen.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class Formtransaksi extends StatefulWidget {
  final Map<String, dynamic> datajadwal;

  Formtransaksi({required this.datajadwal});

  @override
  State<Formtransaksi> createState() => _FormtransaksiState();
}

class _FormtransaksiState extends State<Formtransaksi> {
  var totalbayar = 0.0;
  var jumlahbeli = 1.0;
  late double hargatiket;
  FilePickerResult? filePickerResult;

  Response? response;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    hargatiket = widget.datajadwal['hargaTiket'];
    totalbayar = hargatiket * jumlahbeli;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "https://cdn-icons-png.flaticon.com/128/3029/3029373.png",
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              "Nama Rute",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Laguboti - Medan"),
            SizedBox(height: 10),
            Text(
              "Harga",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("${widget.datajadwal['hargaTiket']}"),
            SizedBox(height: 10),
            Text(
              "Waktu Berangkat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("${widget.datajadwal['waktuBerangkat']}"),
            SizedBox(height: 10),
            Text(
              "Jumlah",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SpinBox(
              min: 1,
              max: 12,
              value: jumlahbeli,
              onChanged: (value) {
                setState(() {
                  jumlahbeli = value;
                  totalbayar = jumlahbeli * hargatiket;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              "Total",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("$totalbayar"),
            SizedBox(height: 10),
            Text(
              "Upload Bukti Pembayaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                filePickerResult = await FilePicker.platform.pickFiles();
                if (filePickerResult != null) {
                  setState(() {});
                }
              },
              child: Text(filePickerResult != null
                  ? "File Selected: ${filePickerResult!.files.single.name}"
                  : "Select File"),
            ),
            SizedBox(height: 30),
            DefaultButtonCustomeColor(
              color: kPrimaryColor,
              text: "Beli",
              press: () {
                if (totalbayar <= 0 || jumlahbeli <= 0) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: "Peringatan",
                    desc: "Jumlah pembelian tiket minimal 1",
                    btnOkOnPress: () {},
                  ).show();
                } else if (filePickerResult == null) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: "Peringatan",
                    desc: "Silakan upload bukti pembayaran",
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    animType: AnimType.rightSlide,
                    title: "Peringatan",
                    desc: "Anda yakin ingin memesan tiket ini?",
                    btnOkOnPress: () {
                      showSuccessDialog(
                        context,
                        'Berhasil..!!',
                        'Hore, Anda berhasil memesan tiket :).',
                      );
                    },
                    btnCancelOnPress: () {},
                  ).show();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void prosesTransaksi(
    String username,
    double jumlah,
    double harga,
    DateTime tanggal,
    String rute,
    String bus,
    String jadwal,
  ) async {
    showDialogLoading(context);
    try {
      var formData = FormData.fromMap({
        'bus': bus,
        'username': username,
        'rute': rute,
        'jadwal': jadwal,
        'jumlah': jumlah,
        'total': harga,
        'harga': hargatiket,
        'tanggal': tanggal.toIso8601String(),
        'file': await MultipartFile.fromFile(
          filePickerResult!.files.single.path!,
          filename: filePickerResult!.files.single.name,
        ),
      });

      var response = await dio.post(CreateTransaksi, data: formData);

      bool status = response.data['sukses'];
      var msg = response.data['msg'];

      hideDialog(context);

      if (status) {
        showSuccessDialog(
            context, 'Berhasil..!!', 'Hore anda berhasil transaksi :).');
      } else {
        showErrorDialog(context, 'Peringatan', 'Gagal transaksi = $msg');
      }
    } catch (e) {
      hideDialog(context);
      showErrorDialog(
          context, 'Peringatan', 'Terjadi kesalahan pada server: $e');
    }
  }

  void showDialogLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void showSuccessDialog(
      BuildContext context, String title, String description) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnOkOnPress: () {
        Navigator.pushNamed(
          context,
          HomeUserScreens.routeName,
        );
      },
    ).show();
  }

  void showErrorDialog(BuildContext context, String title, String description) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: description,
      btnOkOnPress: () {},
    ).show();
  }
}
