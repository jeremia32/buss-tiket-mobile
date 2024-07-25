import 'package:bus_tiket/srceens/user/homeUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:bus_tiket/components/register/regisform.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/srceens/user/bus/buscomponent.dart';
import 'package:bus_tiket/srceens/user/jadwal/Jadwalcomponent.dart';
import 'package:bus_tiket/utils/constants.dart';

class Datajadwalsreen extends StatelessWidget {
  static var routeName = "/jadwal_user";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // Mengambil datauserlogin dari HomeUserScreens
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Jadwal Bus",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: JadwalComponent(),
    );
  }
}
