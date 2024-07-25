import 'package:flutter/material.dart';
import 'package:bus_tiket/size_config.dart';
import 'package:bus_tiket/utils/constants.dart';
import 'package:simple_shadow/simple_shadow.dart';

class RegistrasiComponent extends StatefulWidget {
  @override
  _RegistrasiComponentState createState() => _RegistrasiComponentState();
}

class _RegistrasiComponentState extends State<RegistrasiComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                SimpleShadow(
                  child: Image.asset(
                    "assets/image/icon.png",
                    height: 150,
                    width: 202,
                  ),
                  opacity: 0.5,
                  color: kSecondaryColor,
                  offset: Offset(5, 5),
                  sigma: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Registrasi",
                        style: mTitleStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                buildFullNameFormField(),
                SizedBox(height: 10),
                buildUsernameFormField(),
                SizedBox(height: 10),
                buildEmailFormField(),
                SizedBox(height: 10),
                buildAddressFormField(),
                SizedBox(height: 10),
                buildPasswordFormField(),
                SizedBox(height: 10),
                buildConfirmPasswordFormField(),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(56),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement your registration logic here
                    },
                    child: Text(
                      "Daftar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Lengkap",
        hintText: "Masukkan nama lengkap Anda",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Masukkan username Anda",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Masukkan email Anda",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Alamat",
        hintText: "Masukkan alamat Anda",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_on),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Masukkan password Anda",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
        hintText: "Ulangi password Anda",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
      ),
    );
  }
}
