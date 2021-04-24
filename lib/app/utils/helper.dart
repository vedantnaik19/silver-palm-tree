import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Helper {
  static int randomNumber() {
    Random random = Random();
    return random.nextInt(1000000);
  }

  static double postSize(double screenWidth) {
    double size = (screenWidth / 2 - 16).roundToDouble();
    if (size >= 200) size = 200;
    return size;
  }

  static int crossAxisCount(double postSize) {
    int c = Get.width ~/ postSize;
    if (c == 1) c++;
    return c;
  }

  static String assetPath() {
    int i = Random().nextInt(7);
    return "assets/images/0$i.png";
  }

  static formatNumber(int num) {
    return NumberFormat.compact().format(num);
  }

  static String getDateMonth(int ms) {
    var date = DateTime.fromMillisecondsSinceEpoch(ms);
    return "${date.day.toString().padLeft(2)} ${DateFormat.MMMM().format(date)}";
  }

  static List<String> randomTags() {
    Set randomTags = <String>{};
    List hashtags = ["cheeselove", "kofluence", "kofluencer", "food"];
    // hashtags.forEach((element) {
    //   randomTags.add(hashtags[Random().nextInt(hashtags.length)]);
    // });
    randomTags.add(hashtags[Random().nextInt(hashtags.length)]);
    return randomTags.toList();
  }
}
