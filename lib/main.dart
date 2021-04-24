import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/services/ui_service.dart';
import 'app/services/data_service.dart';
import 'app/utils/app_strings.dart';
import 'app/services/storage_service.dart';
import 'app/utils/app_routes.dart';
import 'app/utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
    GetMaterialApp(
      title: 'Kofluence',
      debugShowCheckedModeBanner: false,
      enableLog: true,
      locale: Locale('en', 'US'),
      translationsKeys: {'en_US': AppStrings.EN_US},
      getPages: AppRoutes.routes,
      initialRoute: '/details',
      theme: AppTheme.getTheme(),
    ),
  );
}

/// Initializing essential services
Future<void> initServices() async {
  await GetStorage.init();
  Get.put(UiService());
  Get.put(StorageService());
  Get.put(DataService());
}
