import 'package:get/get.dart';
import '../controllers/load_balancer_controller.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {

    Get.put(
      LoadBalancerController(),
    );
  }
}