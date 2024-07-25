import 'package:bus_tiket/srceens/admin/CRUD/EditruteScreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/InputbusScreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/editBusSreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/inputruteScreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/InputJadwalScreen.dart';
import 'package:bus_tiket/srceens/admin/homeAdminScreen.dart';
import 'package:bus_tiket/srceens/login/login_screens.dart';
import 'package:bus_tiket/srceens/register/registrasi.dart';
import 'package:bus_tiket/srceens/user/Transaksi/TransaksiScreen.dart';
import 'package:bus_tiket/srceens/user/bayar/BayarScreen.dart';
import 'package:bus_tiket/srceens/user/bus/Databussreen.dart';
import 'package:bus_tiket/srceens/user/homeuserscreen.dart';
import 'package:bus_tiket/srceens/user/jadwal/datajadwalscreen.dart';
import 'package:bus_tiket/srceens/user/rute/Rutescreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  Loginscreens.routeName: (context) => Loginscreens(),
  RegisterScreens.routeName: (context) => RegisterScreens(),

  // buat user
  HomeUserScreens.routeName: (context) => HomeUserScreens(),
  // buat admin
  HomeAdminScreen.routeName: (context) => HomeAdminScreen(),

  // usser
  Databussreen.routeName: (context) => Databussreen(),
  Datajadwalsreen.routeName: (context) => Datajadwalsreen(),
  TransaksiScreen.routeName: (context) => TransaksiScreen(),
  DataRuteScreen.routeName: (context) => DataRuteScreen(),
  // tambah bus
  InputbusScreen.routeName: (context) => InputbusScreen(),
// edit bus
  EditBusSreens.routeName: (context) => EditBusSreens(),

// tambah rute
  InputruteScreen.routeName: (context) => InputruteScreen(),
// edit rute
  EditruteSreens.routeName: (context) => EditruteSreens(),

  // tambah jadwal
  InputjadwalScreen.routeName: (context) => InputjadwalScreen(),
};
