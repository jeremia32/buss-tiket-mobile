import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/srceens/user/Transaksi/TransaksiScreen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:dio/dio.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:bus_tiket/srceens/user/bayar/BayarScreen.dart'; // Import Formbayar

class JadwalComponent extends StatefulWidget {
  const JadwalComponent({Key? key, required}) : super(key: key);

  @override
  State<JadwalComponent> createState() => _JadwalComponentState();
}

class _JadwalComponentState extends State<JadwalComponent> {
  Response? response;
  var dio = Dio();

  List<dynamic>? jadwal;
  List<dynamic>? datarute;
  List<dynamic>? databus;

  @override
  void initState() {
    super.initState();
    GetDatajadwal();
    GetDatarute();
    GetDataBus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (datarute != null && databus != null)
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: jadwal?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return cardjadwal(jadwal![index]);
                    },
                  )
                else
                  Center(
                      child:
                          CircularProgressIndicator()), // Show a loading indicator while data is being fetched
              ],
            ),
          ),
        ),
      ),
    );
  }

  void GetDatarute() async {
    try {
      response = await dio.get(Getallrute);
      if (response!.statusCode == 200) {
        setState(() {
          datarute = response!.data['data'];
        });
      } else {
        _showErrorDialog("Failed to fetch data: ${response!.statusCode}");
      }
    } catch (e) {
      _showErrorDialog("An error occurred: $e");
    }
  }

  void GetDataBus() async {
    try {
      response = await dio.get(Getallbus);
      if (response!.statusCode == 200) {
        setState(() {
          databus = response!.data['data'];
        });
      } else {
        _showErrorDialog("Failed to fetch data: ${response!.statusCode}");
      }
    } catch (e) {
      _showErrorDialog("An error occurred: $e");
    }
  }

  void GetDatajadwal() async {
    try {
      response = await dio.get(Getalljadwal);
      if (response!.statusCode == 200) {
        setState(() {
          jadwal = response!.data['data'];
        });
      } else {
        _berhasilrute("Failed to fetch data: ${response!.statusCode}");
      }
    } catch (e) {
      _berhasilrute("An error occurred: $e");
    }
  }

  void _berhasilrute(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }

  Widget cardjadwal(Map<String, dynamic> data) {
    // Ambil ID bus dan rute dari data jadwal
    String busId = data['bus'];
    String ruteId = data['rute'];
    // Cari nama bus dan rute dari daftar bus dan rute yang sudah ada
    String namaBus = 'Tidak ditemukan';
    String namaRute = 'Tidak ditemukan';

    if (databus != null && busId != null) {
      var bus = databus!.firstWhere(
        (bus) => bus['_id'] == busId,
        orElse: () => null,
      );
      if (bus != null) {
        namaBus = bus['nama'] ?? 'Tidak ditemukan';
      }
    }

    if (datarute != null && ruteId != null) {
      var rute = datarute!.firstWhere(
        (rute) => rute['_id'] == ruteId,
        orElse: () => null,
      );
      if (rute != null) {
        namaRute = rute['namarute'] ?? 'Tidak ditemukan';
      }
    }

    // Ambil data lain dari jadwal dengan pengecekan null
    String tanggalBerangkat = data['tanggalBerangkat'] != null
        ? DateTime.parse(data['tanggalBerangkat'])
            .toLocal()
            .toString()
            .split(' ')[0]
        : 'Tidak tersedia';
    String waktuBerangkat = data['waktuBerangkat'] ?? 'Tidak tersedia';
    String hargaTiket = data['hargaTiket'] != null
        ? data['hargaTiket'].toString()
        : 'Tidak tersedia';
    String status = data['status'] ?? 'Tidak tersedia';

    return GestureDetector(
      onTap: () {
        // Apabila card di-tap, pindah ke halaman Formbayar dengan mengirimkan data jadwal
        Navigator.pushNamed(context, TransaksiScreen.routeName,
            arguments: data); // Navigasi ke BayarScreen
      },
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        right:
                            BorderSide(width: 1.0, color: Colors.grey.shade300),
                      ),
                    ),
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/128/6054/6054293.png",
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama BUS : $namaBus',
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Nama rute: $namaRute',
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Tanggal Berangkat: $tanggalBerangkat',
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Waktu Berangkat: $waktuBerangkat',
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Harga Tiket: $hargaTiket',
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Status: $status',
                        style: TextStyle(
                          color: mTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10), // Tambahkan spasi antara info dan tombol
              ElevatedButton(
                onPressed: () {
                  // Saat tombol ditekan, pindah ke halaman TransaksiScreen
                  Navigator.pushNamed(context, TransaksiScreen.routeName,
                      arguments: data);
                },
                child: Text('Pesan'), // Teks tombol
              ),
            ],
          ),
        ),
      ),
    );
  }
}
