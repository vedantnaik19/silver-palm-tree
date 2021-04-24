import 'package:get/get.dart';

import 'details_controller.dart';

/// Used for injecting dependencies
class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailsController());
    // Get.lazyPut<DetailsController>(() => DetailsController());
  }
}
