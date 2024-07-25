import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/routers.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/srceens/admin/CRUD/EditruteScreen.dart';
import 'package:bus_tiket/srceens/admin/CRUD/editBusSreen.dart';
import 'package:bus_tiket/srceens/admin/homeAdminScreen.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAdmincomponent extends StatefulWidget {
  @override
  _HomeAdmincomponentState createState() => _HomeAdmincomponentState();
}

class _HomeAdmincomponentState extends State<HomeAdmincomponent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Response? response;
  var dio = Dio();
  List<dynamic>? databus;
  List<dynamic>? datarute;
  List<dynamic>? jadwal;

  @override
  void initState() {
    super.initState();
    GetDataBus();
    GetDatarute();
    GetDatajadwal();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Icon(Icons.directions_bus,
                        color: Color.fromARGB(255, 21, 115, 165)), // Ikon Bus
                    SizedBox(width: 10),
                    Text(
                      "Daftar Bus",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 280.0,
                  child: databus != null
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: databus!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return cardDatabus(databus![index]);
                          },
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Icon(Icons.directions_bus, color: Colors.green), // Ikon Bus
                    SizedBox(width: 10),
                    Text(
                      "Rute Bus",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 180.0,
                  child: datarute != null
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: datarute!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return cardDataRute(datarute![index]);
                          },
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Icon(Icons.schedule,
                        color: Color.fromARGB(255, 239, 80, 6)), // Ikon Bus
                    SizedBox(width: 10),
                    Text(
                      "Jadwal Bus",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 180.0, // Meningkatkan tinggi container
                  child: jadwal != null
                      ? GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                1, // Menampilkan dua item dalam satu baris
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 2 /
                                3, // Mengatur rasio aspek child untuk menghindari overflow
                          ),
                          itemCount:
                              jadwal!.length, // Menampilkan semua item jadwal
                          itemBuilder: (BuildContext context, int index) {
                            return cardJadwal(jadwal![index]);
                          },
                        )
                      : Center(child: CircularProgressIndicator()),
                )
              ],
            ),
          ),
        ),
      ),
    );
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

// jadwal
  // Widget untuk menampilkan kartu jadwal
  Widget cardJadwal(Map<String, dynamic> data) {
    // Ambil ID bus dan rute dari data jadwal
    String busId = data['bus'];
    String ruteId = data['rute'];

    // Cari nama bus dan rute dari daftar bus dan rute yang sudah ada
    String namaBus = 'Tidak ditemukan';
    String namaRute = 'Tidak ditemukan';

    if (databus != null) {
      var bus =
          databus!.firstWhere((bus) => bus['_id'] == busId, orElse: () => null);
      if (bus != null) {
        namaBus = bus['nama'];
      }
    }

    if (datarute != null) {
      var rute = datarute!
          .firstWhere((rute) => rute['_id'] == ruteId, orElse: () => null);
      if (rute != null) {
        namaRute = rute['namarute'];
      }
    }

    return Container(
      width: 150, // Lebar gambar diperkecil
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          onTap: () {
            // Tambahkan logika untuk menampilkan detail jadwal
          },
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama rute: $namaRute',
                  style: TextStyle(
                    fontSize: 14.0, // Ukuran font diperkecil
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Nama BUS : $namaBus',
                  style: TextStyle(
                    fontSize: 12.0, // Ukuran font diperkecil
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Tanggal Berangkat: ${data['tanggalBerangkat']}',
                  style: TextStyle(
                    fontSize: 12.0, // Ukuran font diperkecil
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Waktu Berangkat: ${data['waktuBerangkat']}',
                  style: TextStyle(
                    fontSize: 12.0, // Ukuran font diperkecil
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Harga Tiket: ${data['hargaTiket']}',
                  style: TextStyle(
                    fontSize: 12.0, // Ukuran font diperkecil
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status: ${data['status']}',
                      style: TextStyle(
                        fontSize: 12.0, // Ukuran font diperkecil
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman edit saat ikon edit ditekan
                            // Navigator.pushNamed(context, '/edit_jadwal');
                          },
                          child: Icon(Icons.edit, color: Colors.blue, size: 16),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            // Tambahkan logika untuk menonaktifkan jadwal
                          },
                          child: Icon(Icons.power_settings_new,
                              color: Colors.red, size: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// databus
  Widget cardDatabus(data) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 253, 253, 253)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            width: 80, // Lebar gambar
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white)),
            ),
            child: Image.network(
              '$baseUrl/${data['gambar']}',
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error);
              },
            ),
          ),
          title: Text(
            'Nama BUS : ${data['nama']}',
            style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, EditBusSreens.routeName,
                      arguments: data);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: kColorYellow,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "edit",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _showDeleteConfirmation(data['nama']);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: kColorRedSlow,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "HAPUS",
                      style: TextStyle(
                        color: mTitleColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: mTitleColor,
            size: 20.0,
          ),
        ),
      ),
    );
  }

// data rute
  Widget cardDataRute(data) {
    String? namaBus;

    // Ambil ID bus dari objek data
    String busId = data['bus'];

    // Cari objek bus yang sesuai dengan ID tersebut
    Map<String, dynamic>? bus =
        databus?.firstWhere((bus) => bus['_id'] == busId, orElse: () => null);

    // Jika objek bus ditemukan, ambil nama busnya
    if (bus != null) {
      namaBus = bus['nama'];
    }
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        width: 300.0, // Tambahkan properti width

        decoration: BoxDecoration(
          color: Color.fromARGB(255, 253, 253, 253),
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            'Nama bus: ${namaBus ?? 'Tidak ditemukan'}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data['namarute']}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'roboto'),
              ),
              Text(
                '${data['asal']}',
              ),
              SizedBox(height: 5),
              Text(
                '${data['tujuan']}',
              ),
              SizedBox(height: 5),
              Text(
                '${data['durasi']}',
              ),
              SizedBox(height: 5),
              Text(
                '${data['jarak']}',
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, EditruteSreens.routeName,
                      arguments: data);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _showDeleterute(data['bus'], data['_id']);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void HapusdataBus(String namaBus) async {
    try {
      // Temukan ID bus berdasarkan nama
      var bus = databus!
          .firstWhere((item) => item['nama'] == namaBus, orElse: () => null);
      if (bus != null) {
        String idBus = bus['_id'];
        response = await dio.delete('$Hapusbus/$idBus');
        if (response!.statusCode == 200) {
          setState(() {
            print('Menghapus bus   dengan id: $namaBus');

            databus!.removeWhere((item) => item['nama'] == namaBus);
          });
          _showSuccessDialog(response!.data['msg']);
        } else {
          _showErrorDialog("Failed to delete data: ${response!.statusCode}");
        }
      } else {
        _showErrorDialog("Bus not found");
      }
    } catch (e) {
      _showErrorDialog("An error occurred: $e");
    }
  }

  void HapusdataRute(id) async {
    try {
      response = await dio.delete('$Hapusrute/$id');
      if (response!.statusCode == 200) {
        setState(() {
          print('Menghapus rute dengan id: $id');
          datarute!.removeWhere((item) => item['_id'] == id);
        });
        _showSuccessDialog(response!.data['msg']);
      } else {
        _showErrorDialog("Failed to delete data: ${response!.statusCode}");
      }
    } catch (e) {
      _showErrorDialog("An error occurred: $e");
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

  void _showDeleteConfirmation(String name) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Peringatan',
      desc: 'Yakin ingin menghapus $name?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        HapusdataBus(name);
      },
    ).show();
  }

  void _showDeleterute(String name, String id) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Peringatan',
      desc: 'Yakin ingin menghapus rute ini ?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        HapusdataRute(id);
      },
    ).show();
  }

  void _showSuccessDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: message,
      btnOkOnPress: () {},
    ).show();
  }
}
