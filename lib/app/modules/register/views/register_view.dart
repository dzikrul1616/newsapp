import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/app/modules/Widget/views/widget_view.dart';
import 'package:newsapp/app/modules/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String email, password, username;
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
      save();
    }
    ;
  }

  save() async {
    var url = Uri.parse('http://192.168.1.18/newsapp/register.php');
    final response = await http.post(url, body: {
      "username": username,
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);
    int value = data["value"];
    String pesan = data["messege"];
    if (value == 1) {
      setState(() {
        navigator!.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onSaved: (e) => username = e!,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  prefixIcon: Icon(
                    Icons.person,
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
                    return "Please Insert email";
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
                  child: Text('Register'),
                  onPressed: () {
                    check();
                  }),
            ),
            const SizedBox(
              height: 10.0,
            ),
            InkWell(
              child: Text(
                'Login disini',
                style: const TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WidgetView()));
              },
            )
          ],
        ),
      )),
    ));
  }
}
