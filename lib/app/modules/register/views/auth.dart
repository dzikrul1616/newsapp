import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/modules/login/controllers/login_controller.dart';
import 'package:newsapp/app/modules/register/controllers/register_controller.dart';

class auth extends StatefulWidget {
  const auth({Key? key}) : super(key: key);

  @override
  State<auth> createState() => _authState();
}

class _authState extends State<auth> {
  RegisterController registerationControl = Get.put(RegisterController());
  LoginController loginControl = Get.put(LoginController());
  var islogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(36),
        child: Center(
          child: Obx(
            () => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          islogin.value = false;
                        },
                        color: !islogin.value ? Colors.white : Colors.amber,
                        child: Text('Register'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          islogin.value = true;
                        },
                        color: !islogin.value ? Colors.white : Colors.amber,
                        child: Text('Login'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  islogin.value ? loginWidget() : registerWidget()
                ]),
          ),
        ),
      )),
    );
  }

  Widget registerWidget() {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Column(
      children: [
        Container(
          child: TextFormField(
            validator: (e) {
              if (e!.isEmpty) {
                return "Please Insert Username";
              }
            },
            controller: registerationControl.usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
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
                return "Please Insert email";
              }
            },
            controller: registerationControl.emailController,
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
            controller: registerationControl.passwordController,
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
        ElevatedButton(
            child: Text('Register'),
            onPressed: () {
              registerationControl.registerWithEmail();
            }),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget loginWidget() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Column(
      children: [
        Container(
          child: TextFormField(
            validator: (e) {
              if (e!.isEmpty) {
                return "Please Insert email";
              }
            },
            controller: loginControl.emailController,
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
            controller: loginControl.passwordController,
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
        ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              loginControl.loginWithEmail();
            }),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
