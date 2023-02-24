import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/retry.dart';
import 'package:http/http.dart' as http;
import 'app/routes/app_pages.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.WIDGET,
      getPages: AppPages.routes,
    );
  }
}
