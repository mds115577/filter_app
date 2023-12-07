import 'package:get/get.dart';

import '../controllers/filter_home_controller.dart';

class FilterHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterHomeController>(
      () => FilterHomeController(),
    );
  }
}
