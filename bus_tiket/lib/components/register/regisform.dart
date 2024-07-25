// import 'package:bus_tiket/Api/configApi.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// import 'package:bus_tiket/components/custum_surfix_icon.dart';
import 'package:bus_tiket/components/default_button_custome_color.dart';
import 'package:bus_tiket/srceens/login/login_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class RegisForm extends StatefulWidget {
  @override
  _RegisFormState createState() => _RegisFormState();
  

}

class _RegisFormState extends State<RegisForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  String? userName;
  String? address;
  String? password;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool remember = false;
  bool _obscureText = true;
  FocusNode focusNode = FocusNode();

  Response? response;
  var dio = Dio();

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Membalik nilai _obscureText
    });
  }

  @override
  void initState() {
    super.initState();
    // prosesRegistrasi();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          SimpleShadow(
            child: Image.asset(
              "asset/image/icon.png",
              height: 150,
              width: 202,
            ),
            opacity: 0.5,
            color: kSecondaryColor,
            offset: Offset(5, 5),
            sigma: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Registrasi",
            style: mTitleStyle,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'username',
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'asset/icons/User.svg',
                        height: 20,
                        width: 20,
                        color: Colors.grey, // Warna ikon bisa disesuaikan
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama lengkap tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (newValue) => fullName = newValue,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap:
                          _togglePasswordVisibility, // Menangani aksi tap untuk mengubah visibilitas password
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          _obscureText
                              ? 'asset/icons/lock.svg'
                              : 'asset/icons/unlock.svg', // Ganti ikon berdasarkan visibilitas password
                          height: 20,
                          width: 20,
                          color: Colors
                              .grey, // Sesuaikan warna ikon jika diperlukan
                        ),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (newValue) => email = newValue,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                TextFormField(
                  controller: _userName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'asset/icons/user.svg',
                        height: 20,
                        width: 20,
                        color: Colors.grey, // Warna ikon bisa disesuaikan
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (newValue) => email = newValue,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'asset/icons/Mail.svg',

                        height: 20,
                        width: 20,
                        color: Colors.grey, // Warna ikon bisa disesuaikan
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (newValue) => address = newValue,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'asset/icons/Location point.svg',

                        height: 20,
                        width: 20,
                        color: Colors.grey, // Warna ikon bisa disesuaikan
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                  onSaved: (newValue) => password = newValue,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                SizedBox(height: getProportionateScreenHeight(30)),
                DefaultButtonCustomeColor(
                  color: kPrimaryColor,
                  text: "Daftar",
                  press: () {
                    prosesRegistrasi(
                        _fullNameController.text,
                        _emailController.text,
                        _userName.text,
                        _addressController.text,
                        _passwordController.text);
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Loginscreens.routeName);
                  },
                  child: Text(
                    "Sudah punya akun  ? login di sini",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void prosesRegistrasi(String username, String password, String nama,
      String email, String alamat) async {
    utilApps.showDialog(context);
    try {
      var response = await dio.post(urlRegister, data: {
        'username': username,
        'password': password,
        'nama': nama,
        'email': email,
        'alamat': alamat
      });

      bool status = response.data['sukses'];
      var msg = response.data['msg'];

      hideDialog(context);

      if (status) {
        showSuccessDialog(
            context, 'Berhasil..!!', 'Hore anda berhasil registrasi :).');
      } else {
        showErrorDialog(context, 'Peringatan', 'Gagal registrasi = $msg');
      }
    } catch (e) {
      hideDialog(context);
      showErrorDialog(context, 'Peringatan', 'Terjadi kesalahan pada server');
    }
  }

  void showDialogLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void showSuccessDialog(
      BuildContext context, String title, String description) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnOkOnPress: () {
        Navigator.pushNamed(context, Loginscreens.routeName);
      },
    )..show();
  }

  void showErrorDialog(BuildContext context, String title, String description) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: description,
      btnOkOnPress: () {},
    )..show();
  }
}
