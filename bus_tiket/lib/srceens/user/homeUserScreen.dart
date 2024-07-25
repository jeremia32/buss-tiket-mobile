import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/components/user/Homeusercomponent.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/srceens/login/login_screens.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeUserScreens extends StatelessWidget {
  static String routeName = "/Home_user";
  // static Map<String, dynamic>? datauserlogin;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            "E-tiketing",
            style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
          ),
          leading: Icon(
            Icons.home,
            color: mTitleColor,
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.person_2_sharp,
                color: mTitleColor,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Homeusercomponent(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.question,
              animType: AnimType.scale,
              title: 'Yakin ingin keluar?',
              btnCancelOnPress: () {},
              btnCancelText: 'Tidak',
              btnOkText: 'Yakin',
              btnOkOnPress: () {
                Navigator.pushNamed(context, Loginscreens.routeName);
              },
            ).show();
          },
          backgroundColor: kColorRedSlow,
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      );
    }
  }

