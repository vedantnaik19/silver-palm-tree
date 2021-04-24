// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kofluence/app/services/ui_service.dart';
import '../../../app/models/post.dart';
import '../../../app/models/hashtag.dart';
import '../../../app/services/data_service.dart';

/// Controller
class DetailsController extends GetxController {
  final DataService _dataService = Get.find();
  final UiService _uiService = Get.find();
  RxList selectedHashTags = RxList<Hashtag>();
  RxList mandatoryHashTags = RxList<Hashtag>();
  RxList relatedHashTags = RxList<Hashtag>();
  RxList yourPosts = RxList<Post>();
  RxList similarPosts = RxList<Post>();
  final searchScrollCont = ScrollController();
  var isSimPostsLoading = false.obs;

  @override
  void onReady() {
    fetchHashtags();
    fetchYourPosts();
    super.onReady();
  }

  @override
  void onClose() {
    searchScrollCont?.dispose();
    super.onClose();
  }

  void fetchHashtags() {
    try {
      List<Hashtag> mHt = _dataService.fetchManHashtags();
      List<Hashtag> rHt = _dataService.fetchRelHashtags();
      selectedHashTags(mHt);
      relatedHashTags(rHt);
      mandatoryHashTags(mHt);
      fetchSimilarPosts();
    } catch (e) {
      _uiService.showSnack('Failed to fetch hashtags.');
    } finally {}
  }

  void fetchYourPosts() {
    try {
      List<Post> posts = _dataService.fetchYourPosts();
      yourPosts(posts);
    } catch (e) {
      _uiService.showSnack('Failed to fetch your posts.');
    } finally {}
  }

  void onChipTap(Hashtag hashtag) {
    var sHt = selectedHashTags.value.toSet();
    var rHt = relatedHashTags.value.toSet();
    try {
      if (sHt.contains(hashtag)) {
        sHt.remove(hashtag);
        rHt.add(hashtag);
      } else {
        sHt.add(hashtag);
        rHt.remove(hashtag);
      }
    } catch (e) {
      _uiService.showSnack('Failed to perform action. Please try again!');
    } finally {
      selectedHashTags(sHt.toList());
      relatedHashTags(rHt.toList());
      searchScrollCont?.animateTo(
          searchScrollCont.position.maxScrollExtent + 64,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 300));
      fetchSimilarPosts();
    }
  }

  void fetchSimilarPosts() async {
    try {
      isSimPostsLoading(true);
      var list = await _dataService.fetchSimilarPosts(
          hashTags: selectedHashTags.value);
      similarPosts(list);
    } catch (e) {
      _uiService.showSnack('Failed to fetch similar posts.');
    } finally {
      await Future.delayed(Duration(seconds: 2));
      isSimPostsLoading(false);
    }
  }
}
