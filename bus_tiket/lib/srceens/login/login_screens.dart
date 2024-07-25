import 'package:bus_tiket/components/login/login_component.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:flutter/material.dart';

class Loginscreens extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Logincomponent(),
    );
  }
}
