import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kofluence/app/models/post.dart';
import 'package:kofluence/app/utils/helper.dart';
import '../../app/models/hashtag.dart';
import '../../app/services/storage_service.dart';
import '../../app/utils/storage_keys.dart';

/// Service to insert dummy data into database, also used for fetching data from database.
class DataService extends GetxService {
  final StorageService _storageService = Get.find();

  @override
  void onInit() {
    /// Insert dummy data(hashtags, posts) into the database
    saveData();
    super.onInit();
  }

  void saveData() {
    saveHashtags();
    savePosts();
  }

  List<Hashtag> fetchManHashtags() {
    var list = _storageService.get(StorageKeys.MAN_HASHTAGS);
    return List<Hashtag>.from(list.map((x) => Hashtag.fromJson(x)));
  }

  List<Hashtag> fetchRelHashtags() {
    var list = _storageService.get(StorageKeys.REL_HASHTAGS);
    return List<Hashtag>.from(list.map((x) => Hashtag.fromJson(x)));
  }

  List<Post> fetchYourPosts() {
    var list = _storageService.get(StorageKeys.YOUR_POSTS);
    return List<Post>.from(list.map((x) => Post.fromJson(x)));
  }

  Future<List<Post>> fetchSimilarPosts(
      {@required List<Hashtag> hashTags}) async {
    var list = _storageService.get(StorageKeys.SIMILAR_POSTS);
    var filteredPosts =
        await compute(similarPostsTask, {"hashTags": hashTags, "list": list});
    return filteredPosts;
  }

  void saveHashtags() {
    final mHashtags = [
      {"id": 1, "name": "cheeselove"},
      {"id": 2, "name": "kofluence"},
    ];
    final rHashtags = [
      {"id": 3, "name": "kofluencer"},
      {"id": 4, "name": "food"},
    ];
    _storageService.save(StorageKeys.MAN_HASHTAGS, mHashtags);
    _storageService.save(StorageKeys.REL_HASHTAGS, rHashtags);
  }

  void savePosts() {
    final yourPosts = List.generate(
        4,
        (index) => {
              "id": index,
              "createdAt": DateTime.now().millisecondsSinceEpoch,
              "type": index == 0 ? "image" : "video",
              "thumbnail": Helper.assetPath(),
              "likes": Helper.randomNumber(),
              "comments": Helper.randomNumber(),
              "tags": Helper.randomTags()
            });

    final similarPosts = List.generate(
        100,
        (index) => {
              "id": index,
              "createdAt": DateTime.now().millisecondsSinceEpoch,
              "type": Helper.randomNumber() % 2 == 0 ? "image" : "video",
              "thumbnail": Helper.assetPath(),
              "likes": Helper.randomNumber(),
              "comments": Helper.randomNumber(),
              "tags": Helper.randomTags()
            });

    _storageService.save(StorageKeys.YOUR_POSTS, yourPosts);
    _storageService.save(StorageKeys.SIMILAR_POSTS, similarPosts);
  }
}

List<Post> similarPostsTask(Map map) {
  List<String> filterTags = [];
  var hashTags = map["hashTags"];
  var list = map["list"];
  for (int i = 0; i < hashTags.length; i++) {
    filterTags.add(hashTags[i].name);
  }
  List<Post> filteredPosts = [];
  for (int i = 0; i < list.length; i++) {
    if (list[i]["tags"].any((item) => filterTags.contains(item))) {
      filteredPosts.add(Post.fromJson(list[i]));
    }
  }
  return filteredPosts;
}
