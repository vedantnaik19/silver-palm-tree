// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'details_controller.dart';
import '../../../app/utils/helper.dart';
import '../../../app/widgets/bet_loader.dart';
import '../../../app/utils/app_theme.dart';
import '../../../app/widgets/chip_ht.dart';
import '../../../app/widgets/post.dart';

/// View
class DetailsPage extends GetView<DetailsController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double postSize = Helper.postSize(Get.width);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            int crossAxisCount = Helper.crossAxisCount(postSize);
            return Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    buildSearchBar(),
                    buildRelatedHashtags(textTheme),
                    buildYourPosts(textTheme, postSize),
                    buildSimilarPosts(textTheme, crossAxisCount, postSize),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black87,
      selectedLabelStyle: TextStyle(fontSize: 10),
      unselectedLabelStyle: TextStyle(fontSize: 10, color: Colors.black87),
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insights),
          label: 'Insights',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {},
    );
  }

  Obx buildSimilarPosts(
      TextTheme textTheme, int crossAxisCount, double postSize) {
    return Obx(() => AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: controller.similarPosts.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'similarPosts'.tr + ':',
                                style: textTheme.bodyText1
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: controller.isSimPostsLoading.value
                                      ? Container(
                                          height: 12,
                                          width: 12,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Container()),
                            ],
                          ),
                          Text(
                            '${Helper.formatNumber(controller.similarPosts.value.length)} Posts',
                            style: textTheme.bodyText1
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount),
                        itemBuilder: (context, index) => Post(
                            key: Key(controller.similarPosts.value[index].id
                                .toString()),
                            size: postSize,
                            post: controller.similarPosts.value[index]),
                        itemCount: controller.similarPosts.value.length,
                      )
                    ],
                  ),
                )
              : Container(height: 100, child: BetLoader()),
        ));
  }

  Obx buildYourPosts(TextTheme textTheme, double postSize) {
    return Obx(
      () => AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: controller.yourPosts.value.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'yourPosts'.tr + ':',
                      style: textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: postSize,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: controller.yourPosts.value.length,
                        itemBuilder: (context, index) {
                          if (index == 0)
                            return Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Post(
                                size: postSize,
                                post: controller.yourPosts.value[index],
                                key: Key(controller.yourPosts.value[index].id
                                    .toString()),
                              ),
                            );
                          return Post(
                              key: Key(controller.yourPosts.value[index].id
                                  .toString()),
                              size: postSize,
                              post: controller.yourPosts.value[index]);
                        }),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  Obx buildRelatedHashtags(TextTheme textTheme) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: controller.relatedHashTags.value.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'hashtags'.tr + ':',
                          style: textTheme.bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                            height: 24,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  controller.relatedHashTags.value.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ChipHt(
                                        onTap: () {
                                          controller.onChipTap(controller
                                              .relatedHashTags.value[index]);
                                        },
                                        isDelIcon: false,
                                        hashtag: controller
                                            .relatedHashTags.value[index]));
                              },
                            )),
                      ],
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }

  Obx buildSearchBar() {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: controller.selectedHashTags.value.isNotEmpty
                ? Container(
                    height: 38,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(44),
                        border: Border.all(color: AppTheme.yellowLight)),
                    child: ListView.builder(
                      controller: controller.searchScrollCont,
                      itemCount: controller.selectedHashTags.value.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChipHt(
                                onTap: controller.mandatoryHashTags.contains(
                                        controller
                                            .selectedHashTags.value[index])
                                    ? null
                                    : () {
                                        controller.onChipTap(controller
                                            .selectedHashTags.value[index]);
                                      },
                                isDelIcon: !controller.mandatoryHashTags
                                    .contains(controller
                                        .selectedHashTags.value[index]),
                                hashtag:
                                    controller.selectedHashTags.value[index]));
                      },
                    ),
                  )
                : Container(),
          ),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'details'.tr,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {},
      ),
      actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
    );
  }
}
