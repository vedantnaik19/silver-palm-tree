import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Acts as a key-value database
class StorageService extends GetxService {
  GetStorage appStorage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  void save(String key, dynamic value) {
    try {
      appStorage.write(key, value);
    } catch (e) {
      print('StorageService: $e');
    }
  }

  Future<void> eraseData() async {
    try {
      await appStorage.erase();
    } catch (e) {
      print('StorageService: $e');
    }
  }

  dynamic get(String key) {
    try {
      return appStorage.read(key) ?? null;
    } catch (e) {
      print('StorageService: $e');
    }
  }
}
