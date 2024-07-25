import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/components/custum_surfix_icon.dart';
import 'package:bus_tiket/components/default_button_custome_color.dart';
import 'package:bus_tiket/srceens/admin/homeAdminScreen.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FormInputJadwal extends StatefulWidget {
  @override
  _FormInputJadwalState createState() => _FormInputJadwalState();
}

class _FormInputJadwalState extends State<FormInputJadwal> {
  TextEditingController txtTanggalBerangkat = TextEditingController();
  TextEditingController txtHargaTiket = TextEditingController();
  TextEditingController txtStatus = TextEditingController();
  FocusNode focusNodeTanggalBerangkat = FocusNode();
  FocusNode focusNodeHargaTiket = FocusNode();

  Response? response;
  var dio = Dio();
  DateTime? selectedTimeBerangkat;
  String? selectedStatus;
  List<dynamic> busList = [];
  String? selectedBusId;
  DateTime selectedDate = DateTime.now();

  List<dynamic> ruteList = [];
  String? selectedRuteId;

  @override
  void initState() {
    fetchBusList();
    fetchRuteList();

    super.initState();
  }

  Future<void> fetchBusList() async {
    try {
      Response response = await dio.get(Getallbus);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['sukses'] == true) {
          setState(() {
            busList = responseData['data'];
          });
        } else {
          print('Failed to load bus list: ${responseData['message']}');
        }
      } else {
        print('Failed to load bus list');
      }
    } catch (e) {
      print('Error fetching bus list: $e');
    }
  }

// buat rute nya
  Future<void> fetchRuteList() async {
    try {
      Response response = await dio.get(Getallrute);

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['sukses'] == true) {
          setState(() {
            ruteList = responseData['data'];
          });
        } else {
          print('Failed to load rute list: ${responseData['message']}');
        }
      } else {
        print('Failed to load rute list');
      }
    } catch (e) {
      print('Error fetching rute list: $e');
    }
  }

  void _selectTimeBerangkat(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTimeBerangkat = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
        txtTanggalBerangkat.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
  }

  @override
  void dispose() {
    focusNodeTanggalBerangkat.dispose();
    focusNodeHargaTiket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildBusDropdown(),
          SizedBox(height: 30),
          buildRuteDropdown(),
          SizedBox(height: 30),
          buildTanggalBerangkat(),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              _selectTimeBerangkat(context);
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: TextEditingController(
                  text: selectedTimeBerangkat != null
                      ? DateFormat.jm().format(selectedTimeBerangkat!)
                      : '',
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Waktu Berangkat',
                  hintText: 'Pilih waktu berangkat',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.access_time),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          buildHargaTiket(),
          SizedBox(height: 30),
          buildStatusDropdown(),
          SizedBox(height: 30),
          DefaultButtonCustomeColor(
            color: Colors.blue,
            text: "Tambahkan",
            press: () {
              validateAndSubmit();
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void showErrorMessage(String field) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Peringatan',
      desc: '$field tidak boleh kosong',
      btnOkOnPress: () {},
    ).show();
  }

  void validateAndSubmit() {
    if (selectedBusId == null) {
      showErrorMessage('Nama Bus');
      return;
    }
    if (selectedRuteId == null) {
      // Menambah validasi untuk memastikan selectedRuteId tidak null
      showErrorMessage('Nama Rute');
      return;
    }
    if (txtTanggalBerangkat.text.isEmpty) {
      showErrorMessage('Tanggal Berangkat');
      return;
    }
    if (selectedTimeBerangkat == null) {
      showErrorMessage('Waktu Berangkat');
      return;
    }
    if (selectedStatus == null) {
      showErrorMessage('Status');
      return;
    }
    if (txtHargaTiket.text.isEmpty) {
      showErrorMessage('Harga Tiket');
      return;
    }

    inputJadwal(
        selectedBusId!,
        selectedRuteId!,
        txtTanggalBerangkat.text,
        DateFormat.jm().format(selectedTimeBerangkat!),
        txtHargaTiket.text,
        selectedStatus!);
  }

  DropdownButtonFormField<String> buildBusDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedBusId,
      items: busList.map<DropdownMenuItem<String>>((bus) {
        return DropdownMenuItem<String>(
          value: bus['_id'],
          child: Row(
            children: [
              Icon(Icons.directions_bus),
              SizedBox(width: 10),
              Text(bus['nama']),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedBusId = newValue;
        });
      },
      decoration: InputDecoration(
        labelText: 'Nama Bus',
        hintText: 'Pilih nama Bus',
        labelStyle: TextStyle(
          color: focusNodeTanggalBerangkat.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/bus.svg",
        ),
      ),
    );
  }

// dropdown rute
  DropdownButtonFormField<String> buildRuteDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRuteId,
      items: ruteList.map<DropdownMenuItem<String>>((rute) {
        return DropdownMenuItem<String>(
          value: rute['_id'],
          child: Row(
            children: [
              Icon(Icons.directions),
              SizedBox(width: 10),
              Text(rute['namarute']),
            ],
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedRuteId = newValue;
        });
      },
      decoration: InputDecoration(
        labelText: 'Nama Rute',
        hintText: 'Pilih nama Rute',
        labelStyle: TextStyle(
          color: focusNodeTanggalBerangkat.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/rute.svg",
        ),
      ),
    );
  }

  TextFormField buildTanggalBerangkat() {
    return TextFormField(
      controller: txtTanggalBerangkat,
      keyboardType: TextInputType.text,
      focusNode: focusNodeTanggalBerangkat,
      onTap: () {
        _selectDate(context);
      },
      decoration: InputDecoration(
        labelText: 'Tanggal Berangkat',
        hintText: 'Pilih tanggal berangkat',
        labelStyle: TextStyle(
          color: focusNodeTanggalBerangkat.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/calendar.svg",
        ),
      ),
    );
  }

  TextFormField buildHargaTiket() {
    return TextFormField(
      controller: txtHargaTiket,
      keyboardType: TextInputType.number,
      focusNode: focusNodeHargaTiket,
      decoration: InputDecoration(
        labelText: 'Harga Tiket',
        hintText: 'Masukkan harga tiket',
        labelStyle: TextStyle(
          color: focusNodeHargaTiket.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/money.svg",
        ),
      ),
    );
  }

  DropdownButtonFormField<String> buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedStatus,
      items: ['aktif', 'dibatalkan', 'selesai']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedStatus = newValue;
          txtStatus.text = newValue!;
        });
      },
      decoration: InputDecoration(
        labelText: 'Status',
        hintText: 'Pilih status',
        labelStyle: TextStyle(
          color: focusNodeTanggalBerangkat.hasFocus ? Colors.grey : Colors.blue,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/status.svg", // Ganti dengan ikon yang sesuai
        ),
      ),
    );
  }

  void inputJadwal(String bus, String rute, String tanggalBerangkat,
      String waktuBerangkat, String hargaTiket, String status) async {
    print('data di masukkan ');

    print('bus: $bus');
    print('bus: $rute');
    print('Tanggal Berangkat: $tanggalBerangkat');
    print('Waktu Berangkat: $waktuBerangkat');
    print('Harga Tiket: $hargaTiket');
    print('Status: $status');
    // Tambahkan logika untuk menyimpan data jadwal ke backend di sini

    utilApps.showDialog(context);
    bool statuss;
    var msg;
    try {
      // Membersihkan harga tiket agar bisa di parse ke dalam angka
      String cleanedHargaTiket =
          hargaTiket.replaceAll('.', '').replaceAll(',', '.');
      double hargaTiketNumeric = double.parse(cleanedHargaTiket);

      Map<String, dynamic> formData = {
        'bus': bus,
        'rute': rute,
        'tanggalBerangkat': tanggalBerangkat,
        'waktuBerangkat': waktuBerangkat,
        'hargaTiket': hargaTiketNumeric,
        'status': status,
      };
      print('Data yang dikirim: $formData');

      Response response = await dio.post(
        Inputjadwal,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // Mengatur header
          },
        ),
      );

      // Log untuk melihat respons dari server
      print('Respons dari server: ${response.data}');

      statuss = response.data['sukses'];
      msg = response.data['msg'];

      if (statuss) {
        print(statuss);
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Peringatan',
          desc: '$msg',
          btnOkOnPress: () {
            Navigator.of(context, rootNavigator: true).pop();
            Future.delayed(Duration(milliseconds: 300), () {
              Navigator.pushNamed(context, HomeAdminScreen.routeName);
            });
          },
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Peringatan',
          desc: '$msg',
          btnOkOnPress: () {
            utilApps.hideDialog(context);
          },
        ).show();
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Terjadi kesalahan pada server kami !!.... ',
        desc: '$msg',
        btnOkOnPress: () {
          utilApps.hideDialog(context);
        },
      ).show();
    }
  }
}
