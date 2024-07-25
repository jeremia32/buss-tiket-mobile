// import 'package:bus_tiket/components/login/login_component.dart';
import 'package:bus_tiket/components/register/regisform.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:flutter/material.dart';

class RegisterScreens extends StatelessWidget {
  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: RegisForm(),
    );
  }
}
