import 'package:bus_tiket/size_config.dart';
import 'package:flutter/material.dart';
import 'package:bus_tiket/components/user/Transaksi/CreateTransaksi/Transaksicomponents.dart';
import 'package:bus_tiket/utils/constants.dart';

class TransaksiScreen extends StatelessWidget {
  static var routeName = "/form_transaksi_Screen";
  static late Map<String, dynamic> datajadwal; // Tambahkan tipe datanya

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final datajadwal =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print('Data jadwal in transaksi: $datajadwal');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Daftar Transaksi",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: mTitleColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: TransaksiComponents(datajadwal: datajadwal),
    );
  }
}
