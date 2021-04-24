import 'package:get/get.dart';
import '../pages/details/details_binding.dart';
import '../pages/details/details_page.dart';
/// Router and its bindings
class AppRoutes {
  static final routes = [
    GetPage(
      name: '/details',
      page: () => DetailsPage(),
      binding: DetailsBinding(),
    ),
  ];
}
