import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:fisatest/app/constants/assets.dart';

import 'package:fisatest/app/utils/size_config.dart';
import 'package:fisatest/app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardYuGui extends StatelessWidget {
  final CardInfoModel cardInfoModel;
  final VoidCallback function;

  const CardYuGui({
    super.key,
    required this.cardInfoModel,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.sm),
        margin: EdgeInsets.all(SizeConfig.xs),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          border: Border.all(color: Colors.green, width: 0.9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Hero(
            tag: cardInfoModel.id,
            child: CachedNetworkImage(
              imageUrl: cardInfoModel.cardImages?.first.imageUrl ?? "",
              placeholder: (context, url) => SizedBox(
                width: 0.1.sw,
                height: 0.1.sw,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                backgroundImage: const AssetImage(AssetsUIValues.bgLogo),
                radius: 0.1.sw,
              ),
            ),
          ),
          title: Text(
            cardInfoModel.name.toLowerCase(),
            style: AppStyles.bubbleTitleStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
          subtitle: Text(
            cardInfoModel.description.toLowerCase(),
            style: AppStyles.bubbleSubTitleStyle(
              context: context,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
