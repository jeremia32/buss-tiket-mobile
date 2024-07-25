import 'package:bus_tiket/srceens/user/rute/RuteComponent.dart';
import 'package:flutter/material.dart';
import 'package:bus_tiket/components/user/Transaksi/CreateTransaksi/Transaksicomponents.dart';
import 'package:bus_tiket/utils/constants.dart';

class DataRuteScreen extends StatelessWidget {
  static var routeName = "/rute_screens";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Rute yang Tersedia",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        // Tambahkan tombol back di sini
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: mTitleColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: RuteComponent(),
    );
  }
}
