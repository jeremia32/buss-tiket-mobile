// import 'package:flutter/material.dart';

// class BayarScreen extends StatelessWidget {
//   static String routeName = "/bayar";

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> dataJadwal =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

//     // Gunakan dataJadwal untuk menampilkan informasi yang relevan
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Form Pembayaran"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Nama Bus: ${dataJadwal['bus']}"),
//             Text("Nama Rute: ${dataJadwal['rute']}"),
//             Text("Tanggal Berangkat: ${dataJadwal['tanggalBerangkat']}"),
//             Text("Waktu Berangkat: ${dataJadwal['waktuBerangkat']}"),
//             Text("Harga Tiket: ${dataJadwal['hargaTiket']}"),
//             // Tambahkan widget lain untuk menampilkan atau menginput informasi pembayaran
//           ],
//         ),
//       ),
//     );
//   }
// }
