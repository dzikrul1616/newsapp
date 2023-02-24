import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/app/modules/NavigasiItem/Mainmenu.dart';
import 'package:newsapp/app/modules/NavigasiItem/profil.dart';
import 'package:newsapp/app/modules/bottombar/bottombar.dart';
import 'package:newsapp/app/modules/home/views/home_view.dart';
import 'package:newsapp/app/modules/register/views/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/widget_controller.dart';

class WidgetView extends StatefulWidget {
  const WidgetView({Key? key}) : super(key: key);

  @override
  State<WidgetView> createState() => _WidgetViewState();
}

enum LoginStatus { notSignin, signIn }

class _WidgetViewState extends State<WidgetView> {
  LoginStatus _loginStatus = LoginStatus.notSignin;
  late String email, password;
  final _key = new GlobalKey<FormState>();

  bool _securedText = true;

  showHide() {
    setState(() {
      _securedText = !_securedText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    var url = Uri.parse('http://192.168.1.18/newsapp/login.php');
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);

    int value = data['value'];
    String pesan = data['messege'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value);
      });
      print(pesan);
    } else {
      print(pesan);
    }
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignin;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  savePref(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.commit();
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignin:
        return Scaffold(
            body: Form(
          key: _key,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextFormField(
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Please Insert Username";
                      }
                    },
                    onSaved: (e) => email = e!,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: TextFormField(
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Please Insert password";
                      }
                    },
                    onSaved: (e) => password = e!,
                    obscureText: _securedText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: Icon(_securedText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        check();
                      }),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  child: Text(
                    'Register disini',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterView()));
                  },
                )
              ],
            ),
          )),
        ));

      case LoginStatus.signIn:
        return MainMenu(signOut);
    }
  }
}
