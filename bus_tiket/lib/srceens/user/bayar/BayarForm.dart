// import 'package:flutter/material.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:bus_tiket/components/default_button_custome_color.dart';
// import 'package:bus_tiket/srceens/user/homeUserScreen.dart';
// import 'package:bus_tiket/utils/constants.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class Formbayar extends StatefulWidget {
//   final Map<String, dynamic> datajadwal;

//   Formbayar({required this.datajadwal});

//   @override
//   State<Formbayar> createState() => _Formbayar();
// }

// class _Formbayar extends State<Formbayar> {
//   var totalbayar = 0.0;
//   var jumlahbeli = 1.0; // Default value to 1
//   late double hargatiket;
//   PlatformFile? selectedFile;

//   Response? response;
//   var dio = Dio();

//   @override
//   void initState() {
//     super.initState();
//     hargatiket = widget.datajadwal['hargaTiket'];
//     totalbayar = hargatiket; // Initialize totalbayar with the ticket price
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimationLimiter(
//       child: ListView(
//         padding: EdgeInsets.all(16),
//         children: AnimationConfiguration.toStaggeredList(
//           duration: const Duration(milliseconds: 375),
//           childAnimationBuilder: (widget) => SlideAnimation(
//             horizontalOffset: 50.0,
//             child: FadeInAnimation(
//               child: widget,
//             ),
//           ),
//           children: [
//             Card(
//               elevation: 4,
//               margin: EdgeInsets.symmetric(vertical: 10),
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 200,
//                       child: Image.network(
//                         "https://cdn-icons-png.flaticon.com/128/3029/3029373.png",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     buildInfoRow(
//                         "Nama Rute",
//                         widget.datajadwal['laguboti-medan'] ??
//                             'Tidak tersedia'),
//                     buildInfoRow(
//                         "Harga",
//                         widget.datajadwal['hargaTiket'].toString() ??
//                             'Tidak tersedia'),
//                     buildInfoRow(
//                         "Waktu Berangkat",
//                         widget.datajadwal['waktuBerangkat'] ??
//                             'Tidak tersedia'),
//                     SizedBox(height: 10),
//                     Text(
//                       "Jumlah",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     SpinBox(
//                       min: 1,
//                       max: 12,
//                       value: 1,
//                       onChanged: (value) {
//                         setState(() {
//                           jumlahbeli = value;
//                           totalbayar = jumlahbeli * hargatiket;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     buildInfoRow("Total", totalbayar.toStringAsFixed(2)),
//                     SizedBox(height: 10),
//                     Text(
//                       "Unggah File",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton.icon(
//                       icon: Icon(Icons.upload_file),
//                       label: Text(selectedFile == null
//                           ? "Pilih File"
//                           : selectedFile!.name),
//                       onPressed: () async {
//                         FilePickerResult? result =
//                             await FilePicker.platform.pickFiles();

//                         if (result != null) {
//                           setState(() {
//                             selectedFile = result.files.first;
//                           });
//                         }
//                       },
//                     ),
//                     SizedBox(height: 30),
//                     DefaultButtonCustomeColor(
//                       color: kPrimaryColor,
//                       text: "Beli",
//                       press: () {
//                         if (totalbayar <= 0 || jumlahbeli <= 0) {
//                           showWarningDialog(
//                               "Peringatan", "Jumlah pembelian tiket minimal 1");
//                         } else if (selectedFile == null) {
//                           showWarningDialog("Peringatan",
//                               "Harap unggah file terlebih dahulu");
//                         } else {
//                           AwesomeDialog(
//                             context: context,
//                             dialogType: DialogType.question,
//                             animType: AnimType.rightSlide,
//                             title: "Konfirmasi",
//                             desc: "Yakin ingin membeli tiket ini?",
//                             btnCancelOnPress: () {},
//                             btnOkOnPress: () {
//                               showSuccessDialog(
//                                 context,
//                                 "Sukses",
//                                 "Pembelian tiket berhasil!",
//                               );
//                             },
//                           ).show();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildInfoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             value,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }

//   void showSuccessDialog(
//       BuildContext context, String title, String description) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.success,
//       animType: AnimType.rightSlide,
//       title: title,
//       desc: description,
//       btnOkOnPress: () {
//         Navigator.pushNamed(
//           context,
//           HomeUserScreens.routeName,
//         );
//       },
//     ).show();
//   }

//   void showWarningDialog(String title, String description) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.info,
//       animType: AnimType.rightSlide,
//       title: title,
//       desc: description,
//       btnOkOnPress: () {},
//     ).show();
//   }

//   void showErrorDialog(BuildContext context, String title, String description) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.error,
//       animType: AnimType.scale,
//       title: title,
//       desc: description,
//       btnOkOnPress: () {},
//     ).show();
//   }
// } 
