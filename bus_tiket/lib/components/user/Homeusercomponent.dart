import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/srceens/user/Transaksi/TransaksiScreen.dart';
import 'package:bus_tiket/srceens/user/bus/Databussreen.dart';
import 'package:bus_tiket/srceens/user/jadwal/datajadwalscreen.dart';
import 'package:bus_tiket/srceens/user/rute/Rutescreen.dart';
import 'package:bus_tiket/utils/constants.dart';

class Homeusercomponent extends StatefulWidget {
  @override
  _HomeusercomponentState createState() => _HomeusercomponentState();
}

class _HomeusercomponentState extends State<Homeusercomponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Layanan",
                    style: mTitleStyle,
                  ),
                ),
                menulayanan(),
                SizedBox(height: 10),
                menurute(),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Selamat datang Di E-tiketing Kawasan Toba ",
                    style: mTitleStyle,
                  ),
                ),
                SizedBox(height: 20),
                buildCarouselSlider(),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Tentang Etiketing",
                    style: mTitleStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "E-tiketing memberikan kemudahan dalam memesan tiket bus secara online. Nikmati kenyamanan dan kepraktisan dalam melakukan transaksi tiket bus hanya dengan beberapa ketukan jari.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                            height: 1.5,
                            fontFamily:
                                'Roboto', // Sesuaikan dengan font yang Anda inginkan
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Spasi antara teks dan gambar
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                              "asset/image/audi.jpg"), // Ganti dengan path gambar tentang etiketing
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menulayanan() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Databussreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 100,
                decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://cdn-icons-png.flaticon.com/128/2099/2099125.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Bus",
                      style: mServiceTitleStyle,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "List daftar bus",
                      style: mServiceSubtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, TransaksiScreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 100,
                decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://cdn-icons-png.flaticon.com/128/8487/8487150.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Transaksi",
                      style: mServiceTitleStyle,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Daftar Transaksi Anda",
                      style: mServiceSubtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarouselSlider() {
    return CarouselSlider(
      items: [
        buildCarouselItem("asset/image/KBT-BG.jpg"),
        buildCarouselItem("asset/image/kbt2.jpg"),
        buildCarouselItem("asset/image/KBT-BG.jpg"),
        buildCarouselItem("asset/image/audi.jpg"),
      ],
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
      ),
    );
  }

  Widget buildCarouselItem(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget menurute() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DataRuteScreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 100,
                decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://cdn-icons-png.flaticon.com/128/3124/3124263.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Rute Bus",
                      style: mServiceTitleStyle,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Rute bus tersedia",
                      style: mServiceSubtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Datajadwalsreen.routeName);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 100,
                decoration: BoxDecoration(
                  color: mFillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: mBorderColor, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://cdn-icons-png.flaticon.com/128/3652/3652191.png",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Jadwal",
                      style: mServiceTitleStyle,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Daftar Jadwal tersedia",
                      style: mServiceSubtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
