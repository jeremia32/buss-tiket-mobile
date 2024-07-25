
import 'package:bus_tiket/routers.dart';
import 'package:bus_tiket/srceens/login/login_screens.dart';
import 'package:bus_tiket/theme.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(
    MaterialApp(
      title: "tiket bus",
      theme: theme(),
      initialRoute: Loginscreens.routeName,
      routes: routes,
    )
  );
}