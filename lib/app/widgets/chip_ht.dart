import 'package:flutter/material.dart';
import '../../app/models/hashtag.dart';
import '../../app/utils/app_theme.dart';

///  Widget to display hashtag chips
class ChipHt extends StatelessWidget {
  final Hashtag hashtag;
  final Function onTap;
  final bool isDelIcon;

  const ChipHt(
      {Key key,
      @required this.hashtag,
      @required this.onTap,
      @required this.isDelIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Chip(
        key: Key(hashtag.id.toString()),
        backgroundColor: AppTheme.yellowELight,
        deleteIcon: !isDelIcon
            ? Container()
            : Icon(
                Icons.close,
                size: 12,
              ),
        onDeleted: !isDelIcon ? null : onTap,
        visualDensity: VisualDensity(horizontal: 0.0, vertical: -4),
        label: Text(
          '#${hashtag.name}',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
