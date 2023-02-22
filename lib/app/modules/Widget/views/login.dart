import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogin = false;
  String errorMessage = "";
  Future<void> login() async {
    setState(() {
      isLogin = true;
      errorMessage = "";
    });

    final response = await http.post(
      Uri.parse('http://localhost/newsapp/login.php'),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['success'] == true) {
        // Login sukses, simpan data user ke shared preferences atau state management
        // Navigasi ke halaman selanjutnya
      } else {
        setState(() {
          errorMessage = jsonData['message'];
        });
      }
    } else {
      setState(() {
        errorMessage = 'Terjadi kesalahan pada server';
      });
    }

    setState(() {
      isLogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            ElevatedButton(
              onPressed: isLogin ? null : login,
              child: isLogin ? CircularProgressIndicator() : Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
