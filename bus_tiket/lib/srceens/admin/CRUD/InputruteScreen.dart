import 'package:bus_tiket/components/Admin/CRUD/inputbus/Inputbuscomponent.dart';
import 'package:bus_tiket/components/Admin/CRUD/inputrute/Inpurutecomponent.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class InputruteScreen extends StatelessWidget {
  static var routeName = "/Input_rute_sreens";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Input data rute bus ",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Inputrutecomponent(),
    );
  }
}
