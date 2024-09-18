import 'package:fisatest/app/_childrens/container/_childrens/home/models/cards_info_model.dart';
import 'package:fisatest/app/common_widgets/flag_language.dart';
import 'package:fisatest/app/constants/assets.dart';
import 'package:fisatest/app/utils/cubits/theme_cubit.dart';
import 'package:fisatest/app/utils/size_config.dart';
import 'package:fisatest/app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'btn_back_widget.dart';

class AppBarStarWars extends StatelessWidget {
  const AppBarStarWars({
    super.key,
    required this.isBack,
    this.cardInfoModelList,
    this.voidCallbackAction,
  });

  final bool isBack;
  final List<CardInfoModel>? cardInfoModelList;

  final Function(CardInfoModel)? voidCallbackAction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Theme.of(context).primaryColorLight,
      toolbarHeight: size.height * .06,
      elevation: 10,
      leading: isBack
          ? const ButtonBack()
          : Padding(
              padding: EdgeInsets.all(SizeConfig.xs),
              child: const FlagLanguage(),
            ),
      title: Text(
        translate('yu_gi_oh'),
        style: AppStyles.titleStyle(context: context, color: Theme.of(context).primaryColor),
      ),
      centerTitle: true,
      actions: [
        if (!isBack)
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return GestureDetector(
                onTap: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.sm),
                  child: Icon(
                    themeState != ThemeState.light ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
