import 'package:get/get.dart';

import '../controllers/interceptor_controller.dart';

class AppBinding extends Bindings {

  @override
  void dependencies() {

    Get.put(
      InterceptorController(),
    );
  }
}