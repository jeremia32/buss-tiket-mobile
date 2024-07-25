// import 'package:flutter/material.dart';
// import 'package:bus_tiket/size_config.dart';
// import 'package:bus_tiket/utils/constants.dart';
// import 'package:bus_tiket/srceens/user/bayar/BayarForm.dart';

// class BayarComponents extends StatefulWidget {
//   @override
//   _BayarComponentsState createState() => _BayarComponentsState();
// }

// class _BayarComponentsState extends State<BayarComponents> {
//   final Map<String, dynamic> datajadwal = {
//     'laguboti-medan': 'Laguboti ke Medan',
//     'hargaTiket': 150000,
//     'waktuBerangkat': '08:00 AM'
//   };

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Pembayaran'),
//           backgroundColor: kPrimaryColor,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: getProportionateScreenWidth(20),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                   "Bayar!",
//                   style: mTitleStyle,
//                 ),
//                 SizedBox(height: 20),
//                 Formbayar(datajadwal: datajadwal),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
