import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:flutter/material.dart';

class BusComponent extends StatefulWidget {
  const BusComponent({Key? key}) : super(key: key);

  @override
  State<BusComponent> createState() => _BusComponentState();
}

class _BusComponentState extends State<BusComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext, int index) {
                      return cardbus();
                    }),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget cardbus() {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
          child: Container(
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/128/15692/15692801.png"),
              ),
              title: Text(
                "nama bus",
                style:
                    TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ini tipe",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "nomor bus",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "deskripsi",
                    style: TextStyle(
                        color: mTitleColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: mTitleColor,
                size: 30.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
