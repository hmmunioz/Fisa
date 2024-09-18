import 'package:fisatest/app/_childrens/container/_childrens/home/widgets/card_list.dart';
import 'package:fisatest/app/common_widgets/background_widget.dart';
import 'package:fisatest/app/common_widgets/custom_switch.dart';
import 'package:fisatest/app/utils/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fisatest/app/_childrens/init/bloc/init_bloc.dart';
import 'package:fisatest/app/_childrens/container/_childrens/home/bloc/home_bloc.dart';

import 'package:fisatest/app/_childrens/container/_childrens/home/pages/home_interactor.dart';

import 'package:fisatest/app/constants/colors.dart';
import 'package:fisatest/app/constants/constants.dart';
import 'package:fisatest/app/utils/size_config.dart';
import 'package:flutter_translate/flutter_translate.dart';

class HomeUI extends StatelessWidget {
  final HomeInteractor homeInteractor;
  final HomeState state;

  const HomeUI(this.homeInteractor, this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.deathStar.withOpacity(.9),
      body: ScreenUtilInit(
        designSize: ConstantsValues.designSize,
        builder: (context, child) => Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              child: BackgroundWidget(),
            ),
            Container(
              margin: EdgeInsets.all(SizeConfig.mdlg),
              width: MediaQuery.of(context).size.width,
              child: BodyHome(homeInteractor, state),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyHome extends StatelessWidget {
  final HomeInteractor homeInteractor;
  final HomeState homeState;
  const BodyHome(
    this.homeInteractor,
    this.homeState, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<InitBloc, InitState>(
          builder: (_, state) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(SizeConfig.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTabWidget(
                    isBanList: homeState.activeBanlist ?? false,
                    onToggle: (val) {
                      homeInteractor.changeBanList();
                    },
                  ),
                  CardsList(homeInteractor, homeState),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
