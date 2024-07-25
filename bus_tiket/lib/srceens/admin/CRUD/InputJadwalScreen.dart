import 'package:bus_tiket/components/Admin/CRUD/inputbus/Inputbuscomponent.dart';
import 'package:bus_tiket/components/Admin/CRUD/inputjadwal/Inputjadwalcomponent.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class InputjadwalScreen extends StatelessWidget {
  static var routeName = "/Input_jadwal_sreens";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Input Jadwal bus ",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Inputjadwalcomponent(),
      //
    );
  }
}
