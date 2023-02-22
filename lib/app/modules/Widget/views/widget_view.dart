import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:newsapp/app/modules/Widget/views/login.dart';
import 'package:newsapp/app/modules/bottombar/bottombar.dart';
import '../controllers/widget_controller.dart';

class WidgetView extends StatefulWidget {
  const WidgetView({Key? key}) : super(key: key);

  @override
  State<WidgetView> createState() => _WidgetViewState();
}

class _WidgetViewState extends State<WidgetView> {
  late String email, password;
  final _key = new GlobalKey<FormState>();
  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    var url = Uri.parse('http://localhost/newsapp/login.php');
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);
    print(data);
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
                onSaved: (e) => email = e!,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: Icon(
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
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: Icon(
                    Icons.lock,
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                  child: Text('Login Langsung'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomBar()));
                  }),
            ),
          ],
        ),
      )),
    ));
  }
}
