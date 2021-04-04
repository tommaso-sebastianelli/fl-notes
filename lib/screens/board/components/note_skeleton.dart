import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class NoteSkeleton extends StatelessWidget {
  const NoteSkeleton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _skeletonRow(double height, Color color, double widthRatio,
        {double bottomPadding = 4}) {
      return Padding(
        padding: EdgeInsets.only(top: 8, bottom: bottomPadding),
        child: SkeletonAnimation(
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            width: MediaQuery.of(context).size.width / widthRatio,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0), color: color),
          ),
        ),
      );
    }

    return Card(
        child: Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _skeletonRow(18.0, Colors.grey[200], 3, bottomPadding: 6),
          _skeletonRow(15.0, Colors.grey[200], 1.3),
          _skeletonRow(15.0, Colors.grey[200], 1),
          _skeletonRow(15.0, Colors.grey[200], 4),
        ],
      ),
    ));
  }
}
