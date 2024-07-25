import 'package:bus_tiket/components/user/Transaksi/CreateTransaksi/FormTransaksi.dart';
import 'package:flutter/material.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class TransaksiComponents extends StatefulWidget {
  final Map<String, dynamic> datajadwal;

  TransaksiComponents({required this.datajadwal});

  @override
  _TransaksiComponentsState createState() => _TransaksiComponentsState();
}

class _TransaksiComponentsState extends State<TransaksiComponents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Transaksi!",
                        style: mTitleStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Formtransaksi(datajadwal: widget.datajadwal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
