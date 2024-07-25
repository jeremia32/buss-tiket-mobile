import 'package:bus_tiket/components/Admin/CRUD/editbus/EditBusform.dart';
import 'package:bus_tiket/components/Admin/CRUD/editrute/Editruteform.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Editrutecomponent extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _Editrutecomponent createState() => _Editrutecomponent();
}

class _Editrutecomponent extends State<Editrutecomponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Data Rute",
                        style: mTitleStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Formeditrute()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
