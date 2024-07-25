import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/components/Admin/HomeAdmincomponent.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/srceens/admin/CRUD/InputJadwalScreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/InputruteScreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/inputbusScreen.dart';
import 'package:bus_tiket/srceens/login/login_screens.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeAdminScreen extends StatefulWidget {
  static String routeName = "/Home_admin";

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  String _selectedOption = 'Tambah Data';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "E-Tiketing",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.home,
          color: mTitleColor,
        ),
        // Input data
        actions: [
          DropdownButton<String>(
            value: _selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue!;
              });
              if (newValue == "Bus") {
                Navigator.pushNamed(context, InputbusScreen.routeName);
              } else if (newValue == "Jadwal") {
                Navigator.pushNamed(context, InputjadwalScreen.routeName);
              } else if (newValue == "Rute") {
                Navigator.pushNamed(context, InputruteScreen.routeName);
              }
            },
            items: <String>['Tambah Data', 'Bus', 'Jadwal', 'Rute']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    if (value == 'Tambah Data') Icon(Icons.add),
                    SizedBox(width: 5),
                    Text(value),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: HomeAdmincomponent(),
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
