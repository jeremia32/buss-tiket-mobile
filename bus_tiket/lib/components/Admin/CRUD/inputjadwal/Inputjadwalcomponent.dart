import 'package:bus_tiket/components/Admin/CRUD/inputjadwal/Inputjadwalform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Inputjadwalcomponent extends StatefulWidget {
  @override
  _Inputjadwalcomponent createState() => _Inputjadwalcomponent();
}

class _Inputjadwalcomponent extends State<Inputjadwalcomponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today, // Gunakan ikon bawaan Flutter
                        size: 30,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Input Data jadwal",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                FormInputJadwal(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
