// import 'package:bus_tiket/components/login/login_component.dart';
import 'package:bus_tiket/components/register/regisform.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/srceens/user/bus/buscomponent.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class Databussreen extends StatelessWidget {
  static var routeName = "/list_bus_user_sreens";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Daftar Bus",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: BusComponent(),
    );
  }
}
