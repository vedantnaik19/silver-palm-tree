import 'package:flutter/material.dart';
import '../../app/utils/helper.dart';
import '../../app/utils/app_theme.dart';
import '../../app/models/post.dart' as model;

/// Post widget to display items in 'Your Posts' and 'Similar Posts'
class Post extends StatelessWidget {
  final model.Post post;
  final double size;
  const Post({@required Key key, @required this.post, @required this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {},
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          height: size,
          width: size,
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    post.thumbnail,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 72,
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                          end: const Alignment(0.0, 0.8),
                          begin: const Alignment(0.0, -1),
                          colors: <Color>[
                            const Color(0x8A000000),
                            Colors.black.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.white,
                                size: 10,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                Helper.getDateMonth(post.createdAt),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: CircleAvatar(
                              backgroundColor: AppTheme.yellow,
                              child: Icon(
                                post.type == "image"
                                    ? Icons.photo
                                    : Icons.play_circle_fill,
                                color: Colors.black,
                                size: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(color: AppTheme.yellowELight),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 10,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${Helper.formatNumber(post.likes)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Icon(
                              Icons.textsms_rounded,
                              size: 10,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '${Helper.formatNumber(post.comments)}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
