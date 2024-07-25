import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_tiket/Api/configApi.dart';
import 'package:bus_tiket/components/custum_surfix_icon.dart';
import 'package:bus_tiket/components/default_button_custome_color.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/srceens/admin/homeAdminScreen.dart';
import 'package:bus_tiket/srceens/register/registrasi.dart';
import 'package:bus_tiket/srceens/user/homeuserscreen.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signinform extends StatefulWidget {
  @override
  _SigninformState createState() => _SigninformState();
}

class _SigninformState extends State<Signinform> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool remember = false;

  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  FocusNode focusNodeUserName = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  Response? response;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    focusNodeUserName.addListener(() {
      setState(() {});
    });
    focusNodePassword.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNodeUserName.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Tambahkan kunci global ke Form
      child: Column(
        children: [
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                onChanged: (value) {
                  setState(() {
                    remember = value ?? false;
                  });
                },
              ),
              Text("Tetap masuk"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Lupa password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "Masuk",
            press: () {
              prosesLogin(txtUserName.text, txtPassword.text);
            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreens.routeName);
            },
            child: Text(
              "Belum bukan akun ? Daftar di sini",
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUserName,
      keyboardType: TextInputType.text,
      focusNode: focusNodeUserName, // Terapkan focusNode ke TextFormField
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Masukkan username Anda',
        labelStyle: TextStyle(
          color: focusNodeUserName.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      keyboardType: TextInputType.text,
      focusNode: focusNodePassword, // Terapkan focusNode ke TextFormField
      style: mTitleStyle,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan password Anda',
        labelStyle: TextStyle(
          color: focusNodePassword.hasFocus ? mSubtitleColor : kPrimaryColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "asset/icons/lock.svg",
        ),
      ),
    );
  }

  void prosesLogin(username, password) async {
    showDialogLoading(context);
    dynamic datauser;
    try {
      var response = await dio.post(urlLogin, data: {
        'username': username,
        'password': password,
      });

      bool status = response.data['sukses'];
      var msg = response.data['msg'];
      datauser = response.data['data'];

      hideDialog(context);

      if (status) {
        showSuccessDialog(
            context, 'Berhasil..!!', 'Hore anda berhasil Login :).', datauser);
      } else {
        showErrorDialog(context, 'Peringatan', 'Gagal Login = $msg');
      }
    } catch (e) {
      hideDialog(context);
      showErrorDialog(context, 'Peringatan', 'Terjadi kesalahan pada servers');
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

  void showSuccessDialog(BuildContext context, String title, String description,
      Map<String, dynamic> datauser) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnOkOnPress: () {
        if (datauser['role'] == 1) {
          Navigator.pushNamed(context, HomeUserScreens.routeName,
              arguments: datauser);
        } else if (datauser['role'] == 2) {
          Navigator.pushNamed(context, HomeAdminScreen.routeName);
        } else {
          print(" halaman tidak tersedia");
        }
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
