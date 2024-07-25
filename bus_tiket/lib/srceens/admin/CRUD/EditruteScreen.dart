import 'package:bus_tiket/components/Admin/CRUD/editbus/EditBusComponent.dart';
import 'package:bus_tiket/components/Admin/CRUD/editrute/Editrutecomponent.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class EditruteSreens extends StatelessWidget {
  static var routeName = "/Edit_rute_sreen";
  static var datarute;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    datarute = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit data Rute",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Editrutecomponent(),
    );
  }
}
