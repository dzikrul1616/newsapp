import 'package:get/get.dart';

import '../controllers/widget_controller.dart';

class WidgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WidgetController>(
      () => WidgetController(),
    );
  }
}
