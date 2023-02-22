import 'package:get/get.dart';

import 'package:newsapp/app/modules/bottombar/bottombar.dart';

import '../modules/Widget/bindings/widget_binding.dart';
import '../modules/Widget/views/widget_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WIDGET,
      page: () => WidgetView(),
      binding: WidgetBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOMBAR,
      page: () => BottomBar(),
    ),
  ];
}
