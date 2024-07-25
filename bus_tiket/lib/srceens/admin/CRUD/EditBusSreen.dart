import 'package:bus_tiket/components/Admin/CRUD/editbus/EditBusComponent.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class EditBusSreens extends StatelessWidget {
  static var routeName ="/Edit_bus_sreens";
  static var databus;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    databus = ModalRoute.of(context)!.settings.arguments as Map;
    print(databus);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit data bus",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Editbuscomponent(),
    );
  }
}
