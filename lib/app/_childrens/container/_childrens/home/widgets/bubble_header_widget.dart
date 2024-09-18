import 'package:fisatest/app/utils/size_config.dart';
import 'package:fisatest/app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BubbleHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;

  const BubbleHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .8.sw,
      height: .07.sh,
      margin: EdgeInsets.all(SizeConfig.sm),
      padding: EdgeInsets.symmetric(horizontal: 0.015.sh, vertical: 0.007.sh),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(SizeConfig.lg),
        border: Border.all(color: Colors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyles.bubbleTitleStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
